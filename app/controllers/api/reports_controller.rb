class Api::ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  respond_to :json
  has_scope :map_scope, type: :boolean
  has_scope :page, default: 1

  # GET /reports
  # GET /reports.json
  def index
    @statuses = Status.all
    @categories = Category.all
    @reports = apply_scopes(Report.includes(:user)).load
    @users = []
    @photos = []
    @reports.each do |report|
      @users << report.user
      @photos << report.start_photo if report.start_photo
    end
    @photos.uniq!
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.status = Status.first

    if current_user
      @report.user = current_user
    end

    @report.location = "POINT(#{report_params[:longitude]} #{report_params[:latitude]})"

    respond_to do |format|
      if @report.save
        subscriber = Subscriber.create(subscribe: @report, user: @report.user)
        SubscriberWorker.perform_async(subscriber.id, :create_notify_mail) if subscriber

        format.json { render action: :show, status: :created }
      else
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    old_status_id = @report.status_id
    @report.location = "POINT(#{report_params[:longitude]} #{report_params[:latitude]})"

    respond_to do |format|
      if @report.update(report_params)
        if old_status_id != @report.status_id
          @report.subscribers.each do |subscriber|
            SubscriberWorker.perform_async(subscriber.id, :update_notify_mail)
          end

          if @report.status.is_final
            @report.closed_at = DateTime.now
            @report.save
          end
        end

        format.json { head :no_content }
      else
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def geocode
    location = location_params
    is_supported = false
    result = {city: ''}

    geoobject = Geocoder.search("#{location[:latitude]}, #{location[:longitude]}")[0]

    return render json: 'not found' unless geoobject

    city = geoobject.address.split(', ')[2]

    if city
      result[:city] = city
      reports = Report.includes(:status).where('address LIKE ? AND is_deleted = ?', "%#{city}%", false)

      if reports.count > 0
        opened = 0
        closed = 0
        all = 0
        users = []

        reports.each do |r|
          all = all + 1
          if r.status.is_final
            closed = closed + 1
          else
            opened = opened + 1
          end

          users << r.user_id unless users.include? r.user_id
        end
        result[:stats] = {
            all: all,
            opened: opened,
            closed: closed,
            users: users.count
        }
      end
    end

    render json: result.to_json
  end

  private
    def location_params
      params.require(:location).permit(:latitude, :longitude)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.normal_scope.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:title, :description, :is_deleted, :user_id, :latitude, :longitude, :address,
                                     :start_photo_id, :end_photo_id, :status_id, :category_id
      )
    end

    def record_not_found
      render text: '404 Not Found', status: 404
    end
end

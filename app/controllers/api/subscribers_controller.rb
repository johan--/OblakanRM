class Api::SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:show, :edit, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  respond_to :json
  has_scope :by_user
  has_scope :by_stype
  has_scope :by_sid

  # GET /subscribers
  # GET /subscribers.json
  def index
    if params[:user_id].present? and params[:code].present?
      @subscribers = Subscriber.where(user_id: params[:user_id].to_i, code: params[:code])
    else
      @subscribers = apply_scopes(Subscriber).all
    end
  end

  # GET /subscribers/1
  # GET /subscribers/1.json
  def show
  end

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.new
  end

  # GET /subscribers/1/edit
  def edit
  end

  # POST /subscribers
  # POST /subscribers.json
  def create
    @subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if @subscriber.save
        SubscriberWorker.perform_async(@subscriber.id, :create_notify_mail)
        format.json { render action: 'show', status: :created }
      else
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscribers/1
  # DELETE /subscribers/1.json
  def destroy
    # TODO: refactor
    respond_to do |format|
      if user_signed_in?
        if @subscriber.user == current_user
          SubscriberWorker.perform_async(@subscriber.id, :delete_notify_mail)
          @subscriber.destroy
        else
          format.json { render json: 'Вам необходимо войти под своей учётной записью', status: :unprocessable_entity }
        end
      else
        if params[:code].present? && @subscriber.code == params[:code]
          SubscriberWorker.perform_async(@subscriber.id, :delete_notify_mail)
          @subscriber.destroy
        else
          format.json { render json: "Неправильный код доступа: #{@subscriber.code}", status: :unprocessable_entity }
        end
      end

      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscriber_params
      params.require(:subscriber).permit(:user_id, :subscribe_type, :subscribe_id)
    end

    def record_not_found
      render text: '404 Not Found', status: 404
    end
end

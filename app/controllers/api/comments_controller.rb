class Api::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :announce]

  respond_to :json

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  def announce
    unless current_user.is_admin
      render json: 'need authorization', status: :unprocessable_entity
    end

    @comment.commentable.subscribers.each do |subscriber|
      SubscriberWorker.perform_async(subscriber.id, :comment_notify_mail, { comment_id: @comment.id })
    end

    render json: 'ok'
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        #@comment.create_activity :create, owner: current_user
        format.json { render action: :show, status: :created }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      render 'api/comments/show'
    else
      format.html { render action: 'edit' }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :commentable_type, :commentable_id, :is_deleted)
    end
end

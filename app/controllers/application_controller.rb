class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include PublicActivity::StoreController

  def index
    # TODO: move to more proper place
    @project_title = 'Общественная карта проблем'
    render template: 'layouts/application'
  end
end

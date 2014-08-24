class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def oblakan
    oauth_data = request.env['omniauth.auth']

    @user = User.find_oblakan_oauth(oauth_data)
    @user.update_oblakan_credentials(oauth_data)

    @user.save

    sign_in_and_redirect @user
  end
end
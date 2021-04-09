class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    @user = User.form_omniauth(request.env['omniauth.auth'])
  end
end

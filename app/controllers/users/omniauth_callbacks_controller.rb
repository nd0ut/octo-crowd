class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.persisted?
      sign_in_and_redirect user
    else
      user.skip_confirmation!

      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :vkontakte, :all
  alias_method :google_oauth2, :all
end
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    # if user wants to cancel login through social
    if params.has_key?(:reset)
      session.delete('devise.user_attributes')
      redirect_to new_user_registration_url
    else
      super
    end
  end
end
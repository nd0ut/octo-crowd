class SubscriptionsController < ApplicationController
  load_and_authorize_resource only: [:show]

  def show
    @subscription = current_user.subscription
  end

  def reset
    if user = User.read_access_token(params[:signature])
      user.subscription.categories.delete_all

      if user == current_user
        redirect_to root_path, notice: t('.signed_unsubscribed')
      else
        redirect_to root_path, notice: t('.unsigned_unsubscribed', email: user.email)
      end
    else
      redirect_to root_path, alert: t('.invalid_link')
    end
  end
end
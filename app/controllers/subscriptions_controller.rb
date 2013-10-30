class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @subscription = current_user.subscription
  end
end
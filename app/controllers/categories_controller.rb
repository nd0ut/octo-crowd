class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.with_moderation_state(:accepted).page(params[:page])
    @categories = Category.all.decorate
  end

  def subscribe
    category = Category.find(params[:category_id])
    current_user.add_subscription_to(category)

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render nothing: true, stasus: 200 }
    end
  end

  def unsubscribe
    category = Category.find(params[:category_id])
    current_user.remove_subscription_from(category)

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render nothing: true, stasus: 200 }
    end
  end
end
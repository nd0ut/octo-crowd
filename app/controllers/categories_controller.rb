class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.page(params[:page])
    @categories = Category.all.decorate
  end
end
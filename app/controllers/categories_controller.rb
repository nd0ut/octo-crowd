class CategoriesController < ApplicationController
  def show
    @posts = Category.find(params[:id]).posts.page(params[:page])
    @categories = Category.all.decorate
  end
end
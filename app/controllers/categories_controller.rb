class CategoriesController < ApplicationController
  def show
    @posts = Category.find(params[:id]).posts
  end
end
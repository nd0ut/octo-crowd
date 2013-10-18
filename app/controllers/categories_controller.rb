class CategoriesController < ApplicationController
  def show
    # params[:id] is the name of the cotegory, not the id
    @posts = Category.where(name: params[:id]).first.posts
  end
end
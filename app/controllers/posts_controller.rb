class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.save

    redirect_to @post
  end

  def show
    @post = Post.find(params[:id]).decorate
    @comments = CommentDecorator.decorate_collection(@post.comments.all)

    @new_comment = Comment.new
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, category_ids: [])
  end
end
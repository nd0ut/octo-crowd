class PostsController < ApplicationController
  def index
    @posts = Post.with_moderation_state(:accepted).page(params[:page])
    @categories = Category.all.decorate
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
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
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
    @comments = CommentDecorator.decorate_collection(@post.root_comments)

    @new_comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])

    if current_user.admin? or current_user == @post.author
      @post.destroy

      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render nothing: true, stasus: 200 }
      end

    else
      respond_to do |format|
        format.html { redirect_to @post }
        format.json { render nothing: true, stasus: 404 }
      end
    end

  end

  private
  def post_params
    params.require(:post).permit(:title, :body, category_ids: [])
  end
end
class Posts::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id]).decorate
    @post.comments.create(user: current_user || nil, comment: params[:comment][:comment])

    redirect_to @post
  end

  private
  def comment_params
    params.require(:comment).permit(:user, :comment)
  end
end
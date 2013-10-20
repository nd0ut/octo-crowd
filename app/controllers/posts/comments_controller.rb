class Posts::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id]).decorate
    @post.comments.create(user: current_user || nil, comment: params[:comment][:comment])

    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])

    if current_user.admin? or current_user == @comment.user
      @comment.destroy

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
  def comment_params
    params.require(:comment).permit(:user, :comment)
  end
end
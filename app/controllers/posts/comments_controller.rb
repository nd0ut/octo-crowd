class Posts::CommentsController < ApplicationController
  before_filter :authenticate_admin_user!, only: [:destroy]

  def create
    post = Post.find(params[:post_id]).decorate
    user = current_user || nil
    comment = Comment.build_from(post, user.try(:id), params[:comment][:body] )
    comment.save

    if parent = post.comment_threads.where(id: params[:parent]).first
      comment.move_to_child_of(parent)
    end


    redirect_to post
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comment_threads.find(params[:comment_id])

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
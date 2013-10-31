class Posts::CommentsController < ApplicationController
  load_and_authorize_resource only: [:destroy]

  def create
    post = Post.find(params[:post_id]).decorate
    user = current_user || User.new
    comment = Comment.build_from(post, user.id, comment_params[:body] )
    comment.save

    if parent = post.comment_threads.where(id: comment_params[:parent]).first
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
        format.json { render nothing: true, status: 200 }
      end

    else
      respond_to do |format|
        format.html { redirect_to @post }
        format.json { render nothing: true, status: 404 }
      end
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:parent, :body)
  end
end
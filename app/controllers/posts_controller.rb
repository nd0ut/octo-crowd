class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :preview]
  before_filter :authenticate_admin_user!, only: [:destroy]

  def index
    @posts = Post.with_moderation_state(:accepted).includes(:author, :tags, :categories).page(params[:page])
    @categories = Category.all.decorate
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    @post.accept if current_user.admin?

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

  def preview
    @post = current_user.posts.new(post_params).decorate
    @tags = post_params[:tag_list].split(', ')

    respond_to do |format|
      format.html { redirect_to @post }
      format.json { render json: { html: render_to_string(partial: 'posts/post_preview.html.slim', locals: { post: @post }) } }
    end
  end

  def by_tag
    @tag = params[:tag]
    @posts = Post.tagged_with(@tag).page(params[:page])
    @categories = Category.all.decorate

    render 'search'
  end

  def search
    @query = search_query
    @posts = Post.search(@query).page(params[:page])
    @categories = Category.all.decorate

    render 'search'
  end

  private
  def search_query
    Riddle::Query.escape(ActionController::Base.helpers.strip_tags(params[:search]))
  end

  def post_params
    params.require(:post).permit(:title, :body, :tag_list, category_ids: [])
  end
end
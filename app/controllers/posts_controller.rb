class PostsController < ApplicationController
  load_and_authorize_resource only: [:create, :destroy, :update]

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
    @comments = CommentDecorator.decorate_collection(@post.root_comments.includes(:children, :user))

    @new_comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if current_user.admin? or current_user == @post.author
      @post.destroy

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

  def search
    @search_query = search_query

    @posts = Post.search(@search_query[:query], conditions: { tags: @search_query[:tags] }).page(params[:page])
    @categories = Category.all.decorate
  end

  private
  def search_query
    query = Riddle::Query.escape(params[:q].strip_tags)

    tag_regex = /\[[^\[\]]+\]/i

    tags = []

    query.gsub!(tag_regex) do |tag|
      tags << tag.delete('[]')
      nil
    end

    { query: query, tags: tags }
  end

  def post_params
    params.require(:post).permit(:title, :body, :tag_list, category_ids: [])
  end
end
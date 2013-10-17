class HomeController < ApplicationController
  def index
    @posts = Post.with_moderation_state(:accepted).order('updated_at desc')
  end
end

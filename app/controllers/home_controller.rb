class HomeController < ApplicationController
  def index
    @posts = Post.with_moderation_state(:accepted)
  end
end

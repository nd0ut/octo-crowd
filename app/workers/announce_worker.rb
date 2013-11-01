class AnnounceWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.where(id: post_id).first
    return if post.nil?

    post.subscriptions.includes(:user).where('user_id NOT IN (?)', post.author.id).uniq.each do |s|
      UserMailer.announce_post(s.user, post).deliver
    end
  end
end
class UserMailer < ActionMailer::Base
  def post_accepted(post)
    @post = post.decorate
    mail(to: @post.author.email, subject: 'Your post accepted')
  end

  def post_rejected(post)
    @post = post.decorate
    mail(to: @post.author.email, subject: 'Your post rejected. Sorry.')
  end

  def announce_post(user, post, category)
    @category = category.decorate
    @post = post.decorate

    mail(to: user.email, subject: "New post at #{@category.name} category")
  end
end

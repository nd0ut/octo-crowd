class UserMailer < ActionMailer::Base
  default from: "mailer@octo-crowd.com"

  def post_accepted(post)
    @post = post
    mail(to: @post.author.email, subject: 'Welcome to My Awesome Site')
  end

  def post_rejected(post)
    @post = post
    mail(to: @post.author.email, subject: 'Welcome to My Awesome Site')
  end
end

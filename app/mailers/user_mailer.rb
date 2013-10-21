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

  def announce_post(user, post, category)
    @category = category.decorate
    @post = post.decorate

    mail(to: user.email, subject: "New post at #{@category.name} category")
  end
end

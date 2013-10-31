class UserMailer < ActionMailer::Base
  default from: 'mailer@octo.crowded.in'

  def post_accepted(post)
    @post = post.decorate
    mail(to: @post.author.email, subject: 'Your post accepted')
  end

  def post_rejected(post)
    @post = post.decorate
    mail(to: @post.author.email, subject: 'Your post rejected. Sorry.')
  end

  def announce_post(user, post)
    @post = post.decorate
    @user = user

    mail(to: @user.email, subject: @post.title)
  end
end

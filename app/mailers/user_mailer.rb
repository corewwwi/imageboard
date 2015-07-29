class UserMailer < ApplicationMailer
  default from: 'admin@example.com'

  def new_message(user, post)
    @user = user
    @post = post
    @thr = post.thr
    mail(to: @user.email, subject: "New message in thread \"#{@thr.title}\"")
  end
end

class UserMailer < ApplicationMailer

  def new_message(user, post)
    @user = user
    @post = post
    @thr = post.thr
    mail(to: @user.email, subject: "New message in thread \"#{@thr.title}\"")

    mail subject: "New message in thread \"#{@thr.title}\"",
         to:      @user.email,
         from:    "admin@example.com"
  end
end

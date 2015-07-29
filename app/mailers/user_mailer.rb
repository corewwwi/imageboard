class UserMailer < ApplicationMailer

  def new_post(user, post)
    @user = user
    @post = post
    @thr = post.thr
    @board = @thr.board
    @url = "localhost:300/#{@board.name}/thrs/#{@thr.id}"
    mail(to: @user.email, subject: "New message in thread \"#{@thr.title}\"", from: "admin@example.com")
  end
end

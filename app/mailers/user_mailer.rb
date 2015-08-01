class UserMailer < ApplicationMailer

  def new_post(user, post)
    @user = user
    @post = post
    @thr = @post.thr
    @board = @thr.board
    @url = board_thr_url(@board, @thr)
    mail(to: @user.email, subject: "New message in thread \"#{@thr.title}\"", from: "qwertyui@example.com")
  end
end

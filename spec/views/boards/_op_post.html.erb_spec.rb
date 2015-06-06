require "rails_helper"

RSpec.describe "rendering locals in a partial" do
  login_user
  let! (:user) { create(:banned) }
  let! (:thr) { create(:thr) }
  let! (:first_post) { create(:post, content: "such fun", user: user) }
  let! (:second_post) { create(:post, user: user) }
  it "displays the post" do
    render :partial => "boards/op_post.html.haml", :locals => { post: thr.posts.first, thr: thr, board: thr.board }
    expect(rendered).to match /such fun/
  end
end
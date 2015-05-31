require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  
  describe "#parent_posts_in_content_to_links" do
    let! (:thr) { FactoryGirl.create(:thr_without_bumplimit) }
    let! (:post) { thr.posts.first }
    it "returns content with links to parent posts" do
      parent_post_id = 123
      post.content = ">>#{parent_post_id} content"
      content_with_parent_posts_links = %Q(#{link_to(">>#{parent_post_id}", board_thr_path(post.thr.board, post.thr, anchor: parent_post_id), data: { anchor: parent_post_id }, class: 'post_anchor' )} content)
      expect(helper.parent_posts_in_content_to_links(post).content).to eq(content_with_parent_posts_links)
    end
  end


end
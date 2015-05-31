module PostsHelper
  include ActionView::Helpers::UrlHelper

  def parent_posts_in_content_to_links (post)
    parent_posts_id = post.content.scan(/>>\d+/).join(' ').scan(/\d+/)
    parent_posts_id.each do |parent_post_id|  
      post.content.sub!(">>#{parent_post_id}", link_to(">>#{parent_post_id}", board_thr_path(post.thr.board, post.thr, anchor: parent_post_id), data: { anchor: parent_post_id }, class: 'post_anchor' )) 
    end
    post
  end 

end

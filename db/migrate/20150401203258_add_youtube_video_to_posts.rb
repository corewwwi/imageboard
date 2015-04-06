class AddYoutubeVideoToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :youtube_video, :string
  end
end

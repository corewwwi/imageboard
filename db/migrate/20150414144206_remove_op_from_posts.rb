class RemoveOpFromPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :op, :boolean
  end
end

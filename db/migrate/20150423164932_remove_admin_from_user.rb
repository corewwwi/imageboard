class RemoveAdminFromUser < ActiveRecord::Migration
  def up
  	remove_column :users, :admin, :boolean, default: false
  end
  def down
  	add_column :users, :admin, :boolean, default: false
  end
end

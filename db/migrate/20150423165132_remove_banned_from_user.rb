class RemoveBannedFromUser < ActiveRecord::Migration

  def up
  	remove_column :users, :banned, :boolean, default: false
  end
  def down
  	add_column :users, :banned, :boolean, default: false
  end
 
end

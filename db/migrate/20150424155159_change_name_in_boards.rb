class ChangeNameInBoards < ActiveRecord::Migration

  def up
  	change_column :boards, :name, :string, default: "", null: false
  	
  end

  def down
  	change_column :boards, :name, :string, null: false
  end	

end

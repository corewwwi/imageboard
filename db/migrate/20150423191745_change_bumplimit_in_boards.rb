class ChangeBumplimitInBoards < ActiveRecord::Migration
  def up
  	change_column :boards, :bumplimit, :integer, default: 500
  	
  end

  def down
  	change_column :boards, :bumplimit, :integer, default: 1000
  end	
end

class ChangeDescriptionAndTermsInBoard < ActiveRecord::Migration
  def up
  	change_column :boards, :description, :string, default: ""
  	change_column :boards, :terms, :string, default: ""
  end

  def down
  	change_column :boards, :terms, :text, default: ""
  	change_column :boards, :description, :text, default: ""
  end	
end

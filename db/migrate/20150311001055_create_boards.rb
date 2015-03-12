class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
    	t.string :name, null: false
    	t.integer :pages_limit, default: 10
    	t.integer :bumplimit, default: 500
    	t.text :description
    	t.text :terms
      t.timestamps null: false
    end
  end
end

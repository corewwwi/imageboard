class CreateThrs < ActiveRecord::Migration
  def change
    create_table :thrs do |t|
        t.integer :user_id
        t.string :title, null:false
        t.integer :board_id, null: false
        
    end
  end
end

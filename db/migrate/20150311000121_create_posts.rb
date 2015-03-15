class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
        t.integer :user_id, null: false
        t.datetime :created_at
        t.text :content, null: false

        t.boolean :sage, default: false
        t.boolean :anon, default: false
        t.integer :thr_id, null: false
        t.boolean :op, null: false
        
    end
  end
end

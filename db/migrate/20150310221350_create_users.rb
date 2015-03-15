class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :login, null: false
        t.string :email, null: false
        t.string :password, null: false
        t.boolean :banned, default: false
    end
  end
end

class AddTableToPosts < ActiveRecord::Migration
  def change
  	create_table :answers_posts, id: false do |t|
      t.belongs_to :answer, index: true
      t.belongs_to :post, index: true
    end
  end
end

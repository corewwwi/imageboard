class AddCreatedAtToThr < ActiveRecord::Migration
  def change
  	add_column :thrs, :created_at, :datetime
  end
end

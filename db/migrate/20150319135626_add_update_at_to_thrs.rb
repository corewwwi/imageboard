class AddUpdateAtToThrs < ActiveRecord::Migration
  def change
  	rename_column :thrs, :bump_time, :updated_at 
  end
end

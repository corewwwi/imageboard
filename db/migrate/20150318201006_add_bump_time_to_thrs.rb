class AddBumpTimeToThrs < ActiveRecord::Migration
  def change
    add_column :thrs, :bump_time, :datetime
  end
end

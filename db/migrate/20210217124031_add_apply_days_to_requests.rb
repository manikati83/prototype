class AddApplyDaysToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :apply_days, :date
  end
end

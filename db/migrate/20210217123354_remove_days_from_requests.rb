class RemoveDaysFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :days, :int
  end
end

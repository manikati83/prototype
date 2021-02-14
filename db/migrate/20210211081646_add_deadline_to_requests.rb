class AddDeadlineToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :deadline, :date
  end
end

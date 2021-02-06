class ChangeColumnDefaultTorequests < ActiveRecord::Migration[5.2]
  def change
    change_column_default :requests, :status, from: nil, to: 0
  end
end

class AddIndexWorkerevaluationsUserId < ActiveRecord::Migration[5.2]
  def change
    add_index :worker_evaluations, [:user_id, :work_id], :unique => true
    add_index :client_evaluations, [:user_id, :work_id], :unique => true
  end
end

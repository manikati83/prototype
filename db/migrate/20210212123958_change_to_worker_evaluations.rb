class ChangeToWorkerEvaluations < ActiveRecord::Migration[5.2]
  def change
    change_column :worker_evaluations, :evaluation, 'float'
  end
end

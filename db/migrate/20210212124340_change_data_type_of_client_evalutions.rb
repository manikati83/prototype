class ChangeDataTypeOfClientEvalutions < ActiveRecord::Migration[5.2]
  def change
    change_column :client_evaluations, :evaluation, 'float'
    
  end
end

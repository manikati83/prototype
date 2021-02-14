class CreateClientEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :client_evaluations do |t|
      t.references :user, foreign_key: true
      t.references :work, foreign_key: true
      t.integer :evaluation
      t.string :content

      t.timestamps
    end
  end
end

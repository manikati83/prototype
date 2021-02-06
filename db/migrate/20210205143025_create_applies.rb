class CreateApplies < ActiveRecord::Migration[5.2]
  def change
    create_table :applies do |t|
      t.references :worker, foreign_key: { to_table: :users }
      t.references :request, foreign_key: { to_table: :requests }
      t.string :content

      t.timestamps
      
      t.index [:worker_id, :request_id], unique: true
    end
  end
end

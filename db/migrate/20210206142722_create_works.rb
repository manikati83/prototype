class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.references :request, foreign_key: true
      t.references :worker, foreign_key: { to_table: :users }
      t.string :image
      t.date :deadline

      t.timestamps
    end
  end
end

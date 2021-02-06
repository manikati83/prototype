class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :client, foreign_key: { to_table: :users }
      t.string :title
      t.text :content
      t.integer :status
      t.string :image
      t.integer :days

      t.timestamps
    end
  end
end

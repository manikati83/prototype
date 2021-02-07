class CreateTalks < ActiveRecord::Migration[5.2]
  def change
    create_table :talks do |t|
      t.references :user, foreign_key: true
      t.references :work, foreign_key: true
      t.string :content
      t.string :image
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

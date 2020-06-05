class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:created_at]
  end
end

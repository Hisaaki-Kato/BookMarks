# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :micropost_id
      t.text :content
      t.timestamps
    end
    add_index :comments, %i[user_id micropost_id created_at]
  end
end

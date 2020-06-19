# frozen_string_literal: true

class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :boards, %i[user_id created_at]
  end
end

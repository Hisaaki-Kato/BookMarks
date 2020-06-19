# frozen_string_literal: true

class AddColumnToBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :title, :string
  end
end

class AddBookIdToBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :book_id, :integer
  end
end

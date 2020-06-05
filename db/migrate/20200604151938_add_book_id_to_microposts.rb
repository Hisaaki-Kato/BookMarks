class AddBookIdToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :book_id, :integer
  end
end

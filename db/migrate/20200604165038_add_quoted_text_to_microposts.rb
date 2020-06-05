class AddQuotedTextToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :quoted_text, :text
  end
end

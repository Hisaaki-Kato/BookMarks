require 'rails_helper'

RSpec.describe Board, type: :model do
  before do
    @board = create(:board)
  end

  #タイトル、ユーザーID、book-ID、内容があれば有効な状態であること
  it "is valid with a title, user_id, book_id, content" do
    board = @board
    expect(board).to be_valid
  end

  #タイトルが無ければ無効な状態であること
  it "is invalid without a title" do
    board = build(:board, title: nil)
    board.valid?
    expect(board.errors[:title]).to include("can't be blank") 
  end
  
  #ユーザーIDが無ければ無効な状態であること
  it "is invalid without a user_id" do
    board = build(:board, user_id: nil)
    board.valid?
    expect(board.errors[:user_id]).to include("can't be blank")
  end

  #book-IDが無ければ無効な状態であること
  it "is invalid without a book_id" do
    board = build(:board, book_id: nil)
    board.valid?
    expect(board.errors[:book_id]).to include("can't be blank")
  end

  #内容が無ければ無効な状態であること
  it "is invalid without a content" do
    board = build(:board, content: nil)
    board.valid?
    expect(board.errors[:content]).to include("can't be blank")
  end

  #内容が400文字以上だと無効な状態であること
  it "is invalid with a content longer than 400 characters" do
    board = build(:board, content: "a"*401)
    board.valid?
    expect(board.errors[:content]).to include("is too long (maximum is 400 characters)")
  end

  #ユーザー単位では重複したbook_idを許可しないこと
  it "does not allow duplicate book_id per user" do
    new_board = build(:board,
                      title: "anotherboard",
                      content: "anothercontent",
                      user_id: @board.user.id,
                      book_id: @board.book.id)
    new_board.valid?
    expect(new_board.errors[:book_id]).to include("has already been taken")
  end
end

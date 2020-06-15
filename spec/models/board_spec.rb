require 'rails_helper'

RSpec.describe Board, type: :model do
  before do
    @user = User.create(
      name: "Hisaaki",
      email: "tester@example.com",
      password: "hogehoge"
    )
    @book = Book.create(
      title: "testbook",
      image: "image.png"
    )
  end

  #タイトル、ユーザーID、book-ID、内容があれば有効な状態であること
  it "is valid with a title, user_id, book_id, content" do
    board = Board.new(
      title: "testboard",
      user_id: @user.id,
      book_id: @book.id,
      content: "testcontent"
    )
    expect(board).to be_valid
  end

  #タイトルが無ければ無効な状態であること
  it "is invalid without a title" do
    board = Board.new(title: nil)
    board.valid?
    expect(board.errors[:title]).to include("can't be blank") 
  end
  
  #ユーザーIDが無ければ無効な状態であること
  it "is invalid without a user_id" do
    board = Board.new(user_id: nil)
    board.valid?
    expect(board.errors[:user_id]).to include("can't be blank")
  end

  #book-IDが無ければ無効な状態であること
  it "is invalid without a book_id" do
    board = Board.new(book_id: nil)
    board.valid?
    expect(board.errors[:book_id]).to include("can't be blank")
  end

  #内容が無ければ無効な状態であること
  it "is invalid without a content" do
    board = Board.new(content: nil)
    board.valid?
    expect(board.errors[:content]).to include("can't be blank")
  end

  #内容が400文字以上だと無効な状態であること
  it "is invalid with a content longer than 400 characters" do
    board = Board.new(content: "a"*401)
    board.valid?
    expect(board.errors[:content]).to include("is too long (maximum is 400 characters)")
  end

  #ユーザー単位では重複したbook_idを許可しないこと
  it "does not allow duplicate book_id per user" do
    @user.boards.create(
      title: "testboard",
      book_id: @book.id,
      content: "testcontent"
    )
    new_board = @user.boards.build(
      title: "anotherboard",
      book_id: @book.id,
      content: "anothercontent"
    )
    new_board.valid?
    expect(new_board.errors[:book_id]).to include("has already been taken")
  end
end

require 'rails_helper'

RSpec.describe Read, type: :model do
  before do
    @user = User.create(
      name: "Hisaaki",
      email: "tester@example.com",
      password: "hogehoge"
    )
    @book = Book.create(
      title: "testbook",
      image: "test.png"
    )
  end

  #ユーザーID、book-IDがあれば有効な状態であること
  it "is valid with a user_id, book_id" do
    read = Read.new(
      user_id: @user.id,
      book_id: @book.id,
    )
    expect(read).to be_valid
  end
  
  #ユーザーIDが無ければ無効な状態であること
  it "is invalid without a user_id" do
    read= Read.new(user_id: nil)
    read.valid?
    expect(read.errors[:user_id]).to include("can't be blank") 
  end

  #book-IDが無ければ無効な状態であること
  it "is invalid without a micropost_id" do
    read= Read.new(book_id: nil)
    read.valid?
    expect(read.errors[:book_id]).to include("can't be blank") 
  end

  #重複したユーザーID、book-IDのペアは許可しないこと
  it "does not allow duplicate user_id, book_id pairs" do
    read = Read.create(
      user_id: @user.id,
      book_id: @book.id,
    )
    new_read = Read.new(
      user_id: @user.id,
      book_id: @book.id,
    )
    new_read.valid?
    expect(new_read.errors[:book_id]).to include("has already been taken")
  end
end

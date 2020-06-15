require 'rails_helper'

RSpec.describe Micropost, type: :model do
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

  #内容、ユーザーID、book-ID、引用文があれば有効な状態であること
  it "is valid with a content, user_id, book_id, quoted_text" do
    micropost = Micropost.new(
      content: "testmicropost",
      user_id: @user.id,
      book_id: @book.id,
      quoted_text: "testquoted_text"
    )
    expect(micropost).to be_valid
  end
  
  #内容が無ければ無効な状態であること
  it "is invalid without a content" do
    micropost = Micropost.new(content: nil)
    micropost.valid?
    expect(micropost.errors[:content]).to include("can't be blank") 
  end

  #内容が50文字以上だと無効な状態であること
  it "is invalid with a content longer than 140 characters" do
    micropost = Micropost.new(content: 'a'*141)
    micropost.valid?
    expect(micropost.errors[:content]).to include("is too long (maximum is 140 characters)")
  end

  #ユーザーIDが無ければ無効な状態であること
  it "is invalid without a user_id" do
    micropost = Micropost.new(user_id: nil)
    micropost.valid?
    expect(micropost.errors[:user_id]).to include("can't be blank")
  end

  #book-IDが無ければ無効な状態であること
  it "is invalid without a book_id" do
    micropost = Micropost.new(book_id: nil)
    micropost.valid?
    expect(micropost.errors[:book_id]).to include("can't be blank")
  end

  #引用文が無ければ無効な状態であること
  it "is invalid without a quoted_text" do
    micropost = Micropost.new(quoted_text: nil)
    micropost.valid?
    expect(micropost.errors[:quoted_text]).to include("can't be blank")
  end

  #引用文が50文字以上だと無効な状態であること
  it "is invalid with a quoted_text longer than 140 characters" do
    micropost = Micropost.new(quoted_text: 'a'*141)
    micropost.valid?
    expect(micropost.errors[:quoted_text]).to include("is too long (maximum is 140 characters)")
  end
end

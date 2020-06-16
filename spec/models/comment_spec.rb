require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = create(:user)
    @book = create(:book)
    @micropost = create(:micropost,
                        user_id: @user.id,
                        book_id: @book.id,)
  end

  #内容、ユーザーID、マイクロポストIDがあれば有効な状態であること
  it "is valid with a content, user_id, micropost_id" do
    comment = build(:comment,
                    user_id: @user.id,
                    micropost_id: @micropost.id)
    expect(comment).to be_valid
  end
  
  #内容が無ければ無効な状態であること
  it "is invalid without a content" do
    comment = build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include("can't be blank") 
  end

  #内容が140文字以上だと無効な状態であること
  it "is invalid with a content longer than 140 characters" do
    comment = build(:comment, content: 'a'*141)
    comment.valid?
    expect(comment.errors[:content]).to include("is too long (maximum is 140 characters)")
  end

  #ユーザーIDが無ければ無効な状態であること
  it "is invalid without a user_id" do
    comment = build(:comment, user_id: nil)
    comment.valid?
    expect(comment.errors[:user_id]).to include("can't be blank") 
  end

  #マイクロポストIDが無ければ無効な状態であること
  it "is invalid without a micropost_id" do
    comment = build(:comment, micropost_id: nil)
    comment.valid?
    expect(comment.errors[:micropost_id]).to include("can't be blank") 
  end
end

require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = create(:user)
    @book = create(:book)
    @micropost = create(:micropost,
                        user_id: @user.id,
                        book_id: @book.id)
  end

  #ユーザーID、マイクロポストIDがあれば有効な状態であること
  it "is valid with a user_id, micropost_id" do
    like = Like.new(
      user_id: @user.id,
      micropost_id: @micropost.id,
    )
    expect(like).to be_valid
  end
  
  #ユーザーIDが無ければ無効な状態であること
  it "is invalid without a user_id" do
    like= Like.new(user_id: nil)
    like.valid?
    expect(like.errors[:user_id]).to include("can't be blank") 
  end

  #マイクロポストIDが無ければ無効な状態であること
  it "is invalid without a micropost_id" do
    like= Like.new(micropost_id: nil)
    like.valid?
    expect(like.errors[:micropost_id]).to include("can't be blank") 
  end

  #重複したユーザーID、マイクロポストIDのペアは許可しないこと
  it "does not allow duplicate user_id, maicropost_id pairs" do
    like = Like.create(
      user_id: @user.id,
      micropost_id: @micropost.id,
    )
    new_like = Like.new(
      user_id: @user.id,
      micropost_id: @micropost.id,
    )
    new_like.valid?
    expect(new_like.errors[:micropost_id]).to include("has already been taken")
  end
end

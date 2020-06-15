require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user1 = User.create(
      name: "Hisaaki",
      email: "tester@example.com",
      password: "hogehoge"
    )
    @user2 = User.create(
      name: "Kato",
      email: "tester2@example.com",
      password: "foobar"
    )
  end

  #follower-ID、followed-IDがあれば有効な状態であること
  it "is valid with a user_id, book_id" do
    relationship = Relationship.new(
      follower_id: @user1.id,
      followed_id: @user2.id,
    )
    expect(relationship).to be_valid
  end
  
  #follower-IDが無ければ無効な状態であること
  it "is invalid without a follower_id" do
    relationship = Relationship.new(follower_id: nil)
    relationship.valid?
    expect(relationship.errors[:follower_id]).to include("can't be blank") 
  end

  #followed-IDが無ければ無効な状態であること
  it "is invalid without a follower_id" do
    relationship = Relationship.new(followed_id: nil)
    relationship.valid?
    expect(relationship.errors[:followed_id]).to include("can't be blank") 
  end

  #follower-IDとfollowed-IDが同一でないこと
  it "is invalid with the same values between follower_id and followed_id" do
    relationship = Relationship.new(
      follower_id: @user1.id,
      followed_id: @user1.id,
    )
    relationship.valid?
    expect(relationship.errors[:follower_id]).to include("should be different")
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(
      name: "Hisaaki",
      email: "tester@example.com",
      password: "hogehoge"
    )
  end

  #名前、メールアドレス、パスワードがあれば有効な状態であること
  it "is valid with a name, email, password" do
    user = @user
    expect(user).to be_valid
  end

  #名前が無ければ無効な状態であること
  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank") 
  end

  #名前が50文字以上だと無効な状態であること
  it "is invalid with a name longer than 50 characters" do
    user = User.new(name: 'a'*51)
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end
  
  #メールアドレスが無ければ無効な状態であること
  it "is invalid without a email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  #メールアドレスが255文字以上だと無効な状態であること
  it "is invalid with a email longer than 255 characters" do
    user = User.new(email: ('a'*256)+'@example.com')
    user.valid?
    expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end

  #パスワードが無ければ無効な状態であること
  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  #パスワードが6文字以下だと無効な状態であること
  it "is invalid with a password less than 6 characters" do
    user = User.new(password: ('a'*5))
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  #重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email" do
    new_user = User.new(
      name: "Kato",
      email: "tester@example.com",
      password: "foobar"
    )
    new_user.valid?
    expect(new_user.errors[:email]).to include("has already been taken")
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end

  # 名前、メールアドレス、パスワードがあれば有効な状態であること
  it 'is valid with a name, email, password' do
    user = @user
    expect(user).to be_valid
  end

  # 名前が無ければ無効な状態であること
  it 'is invalid without a name' do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  # 名前が50文字以上だと無効な状態であること
  it 'is invalid with a name longer than 50 characters' do
    user = build(:user, name: 'a' * 51)
    user.valid?
    expect(user.errors[:name]).to include('は50文字以内で入力してください')
  end

  # メールアドレスが無ければ無効な状態であること
  it 'is invalid without a email' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  # メールアドレスが255文字以上だと無効な状態であること
  it 'is invalid with a email longer than 255 characters' do
    user = build(:user, email: ('a' * 256) + '@example.com')
    user.valid?
    expect(user.errors[:email]).to include('は255文字以内で入力してください')
  end

  # パスワードが無ければ無効な状態であること
  it 'is invalid without a password' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end

  # パスワードが6文字以下だと無効な状態であること
  it 'is invalid with a password less than 6 characters' do
    user = build(:user, password: ('a' * 5))
    user.valid?
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end

  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email' do
    new_user = build(:user,
                     name: 'Kato',
                     password: 'foobar')
    new_user.valid?
    expect(new_user.errors[:email]).to include('はすでに存在します')
  end
end

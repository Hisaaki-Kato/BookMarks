# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Micropost, type: :model do
  # 内容、ユーザーID、book-ID、引用文があれば有効な状態であること
  it 'is valid with a content, user_id, book_id, quoted_text' do
    micropost = create(:micropost)
    expect(micropost).to be_valid
  end

  # 内容が無ければ無効な状態であること
  it 'is invalid without a content' do
    micropost = build(:micropost, content: nil)
    micropost.valid?
    expect(micropost.errors[:content]).to include('を入力してください')
  end

  # 内容が50文字以上だと無効な状態であること
  it 'is invalid with a content longer than 140 characters' do
    micropost = build(:micropost, content: 'a' * 141)
    micropost.valid?
    expect(micropost.errors[:content]).to include('は140文字以内で入力してください')
  end

  # ユーザーIDが無ければ無効な状態であること
  it 'is invalid without a user_id' do
    micropost = build(:micropost, user_id: nil)
    micropost.valid?
    expect(micropost.errors[:user_id]).to include('を入力してください')
  end

  # book-IDが無ければ無効な状態であること
  it 'is invalid without a book_id' do
    micropost = build(:micropost, book_id: nil)
    micropost.valid?
    expect(micropost.errors[:book_id]).to include('を入力してください')
  end

  # 引用文が無ければ無効な状態であること
  it 'is invalid without a quoted_text' do
    micropost = build(:micropost, quoted_text: nil)
    micropost.valid?
    expect(micropost.errors[:quoted_text]).to include('を入力してください')
  end

  # 引用文が50文字以上だと無効な状態であること
  it 'is invalid with a quoted_text longer than 140 characters' do
    micropost = build(:micropost, quoted_text: 'a' * 141)
    micropost.valid?
    expect(micropost.errors[:quoted_text]).to include('は140文字以内で入力してください')
  end
end

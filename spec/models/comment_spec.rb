# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  # 内容、ユーザーID、マイクロポストIDがあれば有効な状態であること
  it 'is valid with a content, user_id, micropost_id' do
    comment = create(:comment)
    expect(comment).to be_valid
  end

  # 内容が無ければ無効な状態であること
  it 'is invalid without a content' do
    comment = build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include('を入力してください')
  end

  # 内容が140文字以上だと無効な状態であること
  it 'is invalid with a content longer than 140 characters' do
    comment = build(:comment, content: 'a' * 141)
    comment.valid?
    expect(comment.errors[:content]).to include('は140文字以内で入力してください')
  end

  # ユーザーIDが無ければ無効な状態であること
  it 'is invalid without a user_id' do
    comment = build(:comment, user_id: nil)
    comment.valid?
    expect(comment.errors[:user_id]).to include('を入力してください')
  end

  # マイクロポストIDが無ければ無効な状態であること
  it 'is invalid without a micropost_id' do
    comment = build(:comment, micropost_id: nil)
    comment.valid?
    expect(comment.errors[:micropost_id]).to include('を入力してください')
  end
end

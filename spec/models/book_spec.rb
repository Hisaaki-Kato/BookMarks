# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  # タイトルがあれば有効な状態であること
  it 'is valid with a title, image' do
    book = build(:book, image: nil)
    expect(book).to be_valid
  end

  # タイトルが無ければ無効な状態であること
  it 'is invalid without a title' do
    book = build(:book, title: nil)
    book.valid?
    expect(book.errors[:title]).to include("を入力してください")
  end

  # 重複したタイトル、画像のペアは許可しないこと
  it 'does not allow duplicate title, image pairs' do
    book = create(:book)
    new_book = build(:book)
    new_book.valid?
    expect(new_book.errors[:image]).to include('はすでに存在します')
  end
end

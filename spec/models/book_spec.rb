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
    expect(book.errors[:title]).to include("can't be blank")
  end

  # 重複したタイトル、画像のペアは許可しないこと
  it 'does not allow duplicate title, image pairs' do
    book = create(:book)
    new_book = build(:book)
    new_book.valid?
    expect(new_book.errors[:image]).to include('has already been taken')
  end
end

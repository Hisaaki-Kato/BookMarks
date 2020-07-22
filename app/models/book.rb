# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :reads,         dependent: :destroy
  has_many :reading_users, through: :reads, source: :user
  has_many :microposts,    dependent: :destroy
  has_many :boards,        dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :title,   presence: true
  validates :image,   uniqueness: { scope: :title }

  def read_by?(user)
    reads.where(user_id: user.id).exists?
  end

  scope :popular_book_id, lambda {
    joins(:reads).group(:id).count.sort_by { |_, v| v }.reverse.to_h.keys
  }

  def self.popular(num = 3)
    popular_books = []
    rank = 0
    popular_book_id[0..num].each do |id|
      rank += 1
      popular_books << [find(id), rank]
    end
    popular_books
  end
end

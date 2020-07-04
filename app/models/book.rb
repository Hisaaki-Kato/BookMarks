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

  scope :popular_book_id, -> {
    joins(:reads).group(:id).count.sort_by { |_, v| v }.reverse.to_h.keys
  }

  def self.popular(num=2)
    popular_books = []
    self.popular_book_id[0..num].each do |id|
      popular_books << self.find(id)
    end
    return popular_books
  end
end

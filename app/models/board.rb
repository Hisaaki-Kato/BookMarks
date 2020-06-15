class Board < ApplicationRecord
  belongs_to :user
  belongs_to :book
  default_scope -> { order(created_at: :desc) }
  validates :title,   presence: true
  validates :user_id, presence: true
  validates :book_id, presence: true, uniqueness: { scope: :user_id }
  validates :content, presence: true, length: { maximum: 400 }
end

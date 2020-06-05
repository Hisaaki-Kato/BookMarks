class Board < ApplicationRecord
  belongs_to :user
  belongs_to :book
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 400 }
end

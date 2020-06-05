class Micropost < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy

  belongs_to :user
  belongs_to :book
  default_scope -> { order(created_at: :desc) }
  validates :user_id,     presence: true
  validates :quoted_text, presence: true, length: { maximum: 140 }
  validates :content,     presence: true, length: { maximum: 140 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def commented_by?(user)
    comments.where(user_id: user.id).exists?
  end
end

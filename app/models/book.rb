class Book < ApplicationRecord
  has_many :reads,         dependent: :destroy
  has_many :reading_users, through: :reads, source: :user
  has_many :microposts,    dependent: :destroy
  has_many :boards,        dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :title,   presence: true, uniqueness: true

  def read_by?(user)
    reads.where(user_id: user.id).exists?
  end
end

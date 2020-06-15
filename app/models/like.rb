class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id,      presence: true
  validates :micropost_id, presence: true, uniqueness: {scope: :user_id}
end

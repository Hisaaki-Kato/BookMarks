# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id,      presence: true
  validates :micropost_id, presence: true
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
end

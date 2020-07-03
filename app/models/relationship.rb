# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validate  :not_be_the_same

  private

  # followerとfollowedが同一でないこと
  def not_be_the_same
    errors.add(:follower_id, '自分自身をフォローすることはできません') if follower_id == followed_id
  end
end

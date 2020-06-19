# frozen_string_literal: true

class Read < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates  :user_id, presence: true
  validates  :book_id, presence: true, uniqueness: { scope: :user_id }
end

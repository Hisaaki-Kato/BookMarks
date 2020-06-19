# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'testbook' }
    image { 'image.png' }
  end
end

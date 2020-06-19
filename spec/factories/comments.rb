# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'testcomment' }
    association :micropost
    user { micropost.user }
  end
end

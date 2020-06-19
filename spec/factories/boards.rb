# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    title { 'testboard' }
    content { 'testcontent' }
    association :user
    association :book
  end
end

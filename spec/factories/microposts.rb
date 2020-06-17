FactoryBot.define do
  factory :micropost do
    content { "testcontent" }
    quoted_text { "testquoted_text" }
    association :user
    association :book
  end
end

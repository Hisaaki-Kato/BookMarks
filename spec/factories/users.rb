FactoryBot.define do
  factory :user do
    name { "Hisaaki" }
    email { "Hisaaki@example.com" }
    password { "hogehoge" }
  end

  factory :tester, class: User do
    name { "tester" }
    email { "tester@example.com" }
    password { "foobar" }
  end
end

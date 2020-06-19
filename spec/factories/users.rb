# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Hisaaki' }
    email { 'Hisaaki@example.com' }
    password { 'hogehoge' }
  end

  factory :tester, class: User do
    name { 'tester' }
    email { 'tester@example.com' }
    password { 'foobar' }
  end

  factory :admin, class: User do
    name { 'admin' }
    email { 'admin@example.com' }
    password { 'adminpassword' }
    admin { 'true' }
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)

User.create!(name:  "Test User",
  email: "test@railstutorial.org",
  password:              "testtest",
  password_confirmation: "testtest",
  admin: false,
  profile: "Hello, World!")

users = User.order(:created_at).take(3)
50.times do
  content = 'testtest'
  users.each { |user| user.microposts.create!(content: content) }
end
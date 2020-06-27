# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'Admin User',
             email: 'Admin@example.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true)

User.create!(name: 'Test User',
             email: 'test@example.com',
             password: 'hogehoge',
             password_confirmation: 'hogehoge',
             admin: false,
             profile: '私はテストユーザーです。')

#book
Book.create!(title: "test-book",
  image: "/no-image.png")

#micropost
users = User.order(:created_at).take(2)
30.times do
  quoted_text = 'test-quoted_text'
  content_post = 'testpost'
  users.each { |user| user.microposts.create!(quoted_text: quoted_text,
                                              content: content_post,
                                              book_id: 1) }
end

# #board
# title = 'board-title'
# content_board = 'testboard'
# users.each { |user|
#   user.boards.create!(title: title,content: content_board,
#                                    book_id: 1)
#   user.boards.create!(title: title,content: content_board + '2',
#                                    book_id: 2)}

# #comment
# users = User.order(:created_at).take(3)
# posts = Micropost.order(:created_at).take(10)
# 1.times do
#   content_comment = 'testcomment'
#   users.each {
#     |user| user.comments.create!(micropost_id: 1,
#                                  content: content_comment)
#   }
# end

# #relationship
# users = User.all
# users[0].follow(users[1])
# users[0].follow(users[2])
# users[1].follow(users[0])

# # user  = users.first
# # following = users[1,2]
# # followers = users[2]
# # following.each { |followed| user.follow(followed) }
# # followers.each { |follower| follower.follow(user) }

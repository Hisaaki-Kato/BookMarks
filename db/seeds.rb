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

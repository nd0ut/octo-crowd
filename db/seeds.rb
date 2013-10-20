# Categories
Category.create(name: 'health')
Category.create(name: 'lifehacks')
Category.create(name: 'tech')
Category.create(name: 'sport')

# User
User.create(username: 'nd0ut', admin: true, email: 'nd0ut.me@gmail.com', password: 'qweqweqwe')

# Posts
30.times do
  User.last.posts.create(title: 'test', body: 'test', moderation_state: 'accepted')
end
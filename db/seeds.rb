# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者作成
Admin.create!(
  username: 'admin',
  email: 'admin@example.com',
  password_digest: 'password',
  role: 'admin'
)

Post.create!(
  title: 'PHPについて',
  content: 'PHPは素晴らしい',
  is_publish: false,
  published_at: '2023-12-05 11:00:00'
)

Post.create!(
  title: 'Rubyについて',
  content: 'Rubyは素晴らしい',
  is_publish: true,
  published_at: '2023-12-05 12:00:00'
)

Post.create!(
  title: 'Pythonについて',
  content: 'Pythonは素晴らしい',
  is_publish: true,
  published_at: '2023-12-05 12:00:00'
)

Tag.create!(
  name: 'プログラミング',
)

Tag.create!(
  name: 'キャリア',
)

PostTag.create!(
  post_id: 1,
  tag_id: 1
)

Category.create!(
  name: 'API',
)

Category.create!(
  name: 'フロントエンド',
)

PostCategory.create!(
  post_id: 1,
  category_id: 1
)

puts 'Seed data inserted successfully.'

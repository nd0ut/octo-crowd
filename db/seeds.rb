# Factories
FactoryGirl.define do
  sequence(:random_title) {|n| Faker::Lorem.sentence }
  sequence(:random_body) {|n| Faker::Lorem.paragraphs(rand(1..5)).join + '<cut/>' + Faker::Lorem.paragraphs(rand(1..20)).join}
  sequence(:random_tags) {|n| Faker::Lorem.words(rand(1..5)).join(',') }

  sequence(:random_category) {|n| Faker::Lorem.sentence(1, false, 2) }

  sequence(:random_name) {|n| Faker::Internet.user_name }
  sequence(:random_email) {|n| Faker::Internet.email }
  sequence(:random_password) {|n| Faker::Internet.password(8) }

  factory :user, aliases: [:author, :commenter] do
    username { generate(:random_name) }
    email { generate(:random_email) }
    password { generate(:random_password) }
    admin true
  end

  factory :post do
    author

    title { generate(:random_title) }
    body { generate(:random_body) }
    moderation_state "accepted"
    categories { [Category.first(offset: rand(Category.count))] }
    tag_list { generate(:random_tags) }
  end

  factory :category do
    name { generate(:random_category) }
  end

end

# Categories
10.times do
  FactoryGirl.create(:category)
end

# Posts
30.times do
  FactoryGirl.create(:post)
end
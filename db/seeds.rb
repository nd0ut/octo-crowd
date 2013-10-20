require 'lorem-ipsum'

# Factories
FactoryGirl.define do
  sequence(:random_string) {|n| LoremIpsum.generate }

  factory :user, aliases: [:author, :commenter] do
    sequence :username do |n|
      "user#{n}"
    end

    sequence :email do |n|
      "user#{n}@example.com"
    end

    password "qweqweqwe"
    admin true
  end

  factory :post do
    author

    title { generate(:random_string)[0..100] }
    body { generate(:random_string) }
    moderation_state "accepted"
    categories [Category.first, Category.last]
  end

  factory :comment do
    comment { generate(:random_string) }
  end
end

# Categories
Category.create(name: 'health')
Category.create(name: 'lifehacks')
Category.create(name: 'tech')
Category.create(name: 'sport')

# User
FactoryGirl.create(:user)

# Posts
30.times do
  FactoryGirl.create(:post)
end

# Comments
30.times do
  FactoryGirl.create(:comment)
end
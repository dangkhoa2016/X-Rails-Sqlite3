FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "foo1#{n}@example.com" }
    password { "password" }
    username { Faker::Internet.unique.username }

    trait :unique_email do
      email { Faker::Internet.unique.email }
    end
  end
end

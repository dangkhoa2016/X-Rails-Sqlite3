FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password { "password" }
    username { Faker::Internet.username }

    trait :unique_email do
      email { Faker::Internet.unique.email }
    end
  end
end

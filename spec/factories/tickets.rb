FactoryBot.define do
  factory :ticket do
    name { Faker::Lorem.characters(number: 8) }
    email { Faker::Internet.email }
    subject { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters }
    association :user, factory: :user
  end
end

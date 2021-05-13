FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' }
    trait :with_manager_role do
      role { :manager }
    end
  end
end

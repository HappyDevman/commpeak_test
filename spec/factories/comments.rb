FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.characters(number: 20) }
    association :ticket, factory: :ticket
  end
end

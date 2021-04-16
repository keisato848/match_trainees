FactoryBot.define do
  factory :ticket do
    comment { Faker::Alphanumeric.alpha(number: 30) }
  end
end

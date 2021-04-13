FactoryBot.define do
  factory :training do
    owner
    name { Faker::Alphanumeric.alpha(number: 50) }
    place { Faker::Alphanumeric.alpha(number: 100) }
    start_at { rand(1..30).days.days.from_now }
    end_at { start_at + rand(1..30).hours }
    content {  Faker::Alphanumeric.alpha(number: 200)  }
    prefecture_id { rand(2..48) }
    
    after(:build) do |training|
      training.image.attach(io: File.open('public/images/dummy-image.png'), filename: 'dummy-image.png')
    end
  end
end

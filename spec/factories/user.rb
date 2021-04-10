FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'testtest11' }
    password_confirmation { password }
    name { Faker::Name.name }
    provider { 'github' }
    uid { Faker::Config.random.seed }
    image_url { Faker::Avatar.image }
  end
end

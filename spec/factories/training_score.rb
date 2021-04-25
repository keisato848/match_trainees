FactoryBot.define do
  factory :training_score do
    user
    bench_press_weight { Faker::Number.between(from: 10, to: 400) }
    squat_weight { Faker::Number.between(from: 10, to: 400) }
    deadlift_weight { Faker::Number.between(from: 10, to: 400) }
  end
end

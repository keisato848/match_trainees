class TrainingScore < ApplicationRecord
  belongs_to :user

  with_options numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 400 } do
    validates :bench_press_weight
    validates :squat_weight
    validates :deadlift_weight
  end
end

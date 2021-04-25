class CreateUserAdditionalProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_additional_profiles do |t|
      t.integer :bench_press_weight
      t.integer :squat_weight
      t.integer :deadlift_weight
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

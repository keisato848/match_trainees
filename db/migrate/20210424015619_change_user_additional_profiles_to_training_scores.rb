class ChangeUserAdditionalProfilesToTrainingScores < ActiveRecord::Migration[6.0]
  def change
    rename_table :user_additional_profiles, :training_scores
  end
end

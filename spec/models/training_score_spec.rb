require 'rails_helper'

RSpec.describe TrainingScore, type: :model do
  before do
    @user = create(:user)
    @training_score = build(:training_score, user: @user)
  end

  describe 'トレーニングスコアを登録できるとき' do
    it 'スコアが正しく入力されていれば登録できる' do
      expect(@training_score).to be_valid
    end
  end

  describe 'トレーニングスコアを登録できないとき' do
    it 'bench_press_weightが10未満の値だと登録できない' do
      @training_score.bench_press_weight = 5
      @training_score.valid?
      expect(@training_score.errors.full_messages).to include('ベンチプレスの重量は10以上の値にしてください')
    end
    it 'bench_press_weightが401以上の値だと登録できない' do
      @training_score.bench_press_weight = 401
      @training_score.valid?
      expect(@training_score.errors.full_messages).to include('ベンチプレスの重量は400以下の値にしてください')
    end

    it 'squat_weightが10未満の値だと登録できない' do
      @training_score.squat_weight = 5
      @training_score.valid?
      expect(@training_score.errors.full_messages).to include('スクワットの重量は10以上の値にしてください')
    end
    it 'squat_weightが401以上の値だと登録できない' do
      @training_score.squat_weight = 401
      @training_score.valid?
      expect(@training_score.errors.full_messages).to include('スクワットの重量は400以下の値にしてください')
    end

    it 'deadlift_weightが10未満の値だと登録できない' do
      @training_score.deadlift_weight = 5
      @training_score.valid?
      expect(@training_score.errors.full_messages).to include('デッドリフトの重量は10以上の値にしてください')
    end
    it 'deadlift_weightが401以上の値だと登録できない' do
      @training_score.deadlift_weight = 401
      @training_score.valid?
      expect(@training_score.errors.full_messages).to include('デッドリフトの重量は400以下の値にしてください')
    end

    it '登録済みのuserは登録できない' do
      @training_score.save
      @another_training_score = build(:training_score, user: @user)
      @another_training_score.valid?
      expect(@another_training_score.errors.full_messages).to include('ユーザーのトレーニングスコアはすでに登録されています')
    end
  end
end

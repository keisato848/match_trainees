require 'rails_helper'

RSpec.describe Training, type: :model do
  before do
    @user = create(:user)
    @training = build(:training)
  end

  describe 'トレーニング作成ができるとき' do
    it ' image以外のすべてのデータがあれば登録できる' do
      @training.image = nil
      expect(@training).to be_valid
    end
  end

  describe 'トレーニング作成ができないとき' do
    it 'nameがなければ登録できない' do
      @training.name = nil
      @training.valid?
      expect(@training.errors.full_messages).to include('名前を入力してください')
    end
    it 'nameが51文字以上では登録できない' do
      invalid_name = Faker::Alphanumeric.alpha(number: 51)
      @training.name = invalid_name
      @training.valid?
      expect(@training.errors.full_messages).to include('名前は50文字以内で入力してください')
    end
    it 'prefecture_idがなければ登録できない' do
      @training.prefecture_id = nil
      @training.valid?
      expect(@training.errors.full_messages).to include('都道府県を入力してください')
    end
    it 'prefecture_idが1では登録できない' do
      @training.prefecture_id = 1
      @training.valid?
      expect(@training.errors.full_messages).to include('都道府県を選択してください')
    end
    it 'placeがなければ登録できない' do
      @training.place = nil
      @training.valid?
      expect(@training.errors.full_messages).to include('場所を入力してください')
    end
    it 'placeが101文字以上では登録できない' do
      invalid_place = Faker::Alphanumeric.alpha(number: 101)
      @training.place = invalid_place
      @training.valid?
      expect(@training.errors.full_messages).to include('場所は100文字以内で入力してください')
    end
    it 'start_atがなければ登録できない' do
      @training.start_at = nil
      @training.valid?
      expect(@training.errors.full_messages).to include('開始日時を入力してください')
    end
    it 'end_atがなければ登録できない' do
      @training.end_at = nil
      @training.valid?
      expect(@training.errors.full_messages).to include('終了日時を入力してください')
    end
    it 'end_atがstart_atより前であれば登録できない' do
      @training.end_at = rand(1..30).days.days.from_now
      @training.start_at = @training.end_at + rand(1..30).hours
      @training.valid?
      expect(@training.errors.full_messages).to include('開始日時は終了時間よりも前に設定してください')
    end
    it 'contentがなければ登録できない' do
      @training.content = nil
      @training.valid?
      expect(@training.errors.full_messages).to include('内容を入力してください')
    end
    it 'contentが201文字以上では登録できない' do
      invalid_content = Faker::Alphanumeric.alpha(number: 201)
      @training.content = invalid_content
      @training.valid?
      expect(@training.errors.full_messages).to include('内容は200文字以内で入力してください')
    end
    it 'imageのファイル形式がpng,jpg,jpeg以外では登録できない' do
      @training.image.attach(io: File.open('public/images/invalid-image.mp4'), filename: 'invalid-image.mp4')
      @training.valid?
      expect(@training.errors.full_messages).to include('画像のContent Typeが不正です', '画像は不正な画像です')
    end
  end
end

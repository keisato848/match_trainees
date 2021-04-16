require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before do
    @participant_user = create(:user)
    @created_training = create(:training)
    @ticket = build(:ticket, user: @participant_user, training: @created_training)
  end

  describe 'トレーニングに参加できるとき' do
    it 'ユーザー・トレーニング情報があれば参加できる' do
      @ticket.comment = nil
      expect(@ticket).to be_valid
    end
  end

  describe 'トレーニングに参加できないとき' do
    it 'コメントが31字以上だと参加できない' do
      @ticket.comment = Faker::Alphanumeric.alpha(number: 31)
      @ticket.valid?
      expect(@ticket.errors.full_messages).to include('コメントは30文字以内で入力してください')
    end
    it '参加済みのユーザーは重複して参加できない' do
      @ticket.save
      @second_ticket = build(:ticket, user: @participant_user, training: @created_training)
      @second_ticket.valid?
      expect(@second_ticket.errors.full_messages).to include('ユーザーはすでに存在します')
    end
  end
end

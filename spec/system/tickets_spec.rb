require 'rails_helper'

RSpec.describe 'tickets', type: :system do
  before do
    @owner = create(:owner)
    @created_training = create(:training)
    @participant_user = create(:user)
    @ticket = build(:ticket, user: @participant_user, training: @created_training)
  end

  context 'トレーニングに参加できるとき' do
    it 'ログイン済ユーザーはトレーニングに参加できる' do
      # ログイン
      sign_in(@participant_user)
      # トレーニング詳細ページへ遷移
      visit training_path(@created_training)
      # トレーニング詳細ページにいることを確認
      expect(current_path).to eq training_path(@created_training)
      # 参加ボタンをクリック
      find('#join-training-path').click
      # コメントを入力し、送信をクリック
      fill_in 'comment', with: @ticket.comment
      click_on '送信'
      # 参加処理が完了し、詳細ページにリダイレクトされていることを確認
      expect(current_path).to eq training_path(@created_training)
      # 参加者にユーザー名が表示されていることを確認
      expect(page).to have_content(@participant_user.name)
      # キャンセルボタンが表示されていることを確認
      expect(page).to have_content('参加をキャンセル')
    end
  end
  context '参加をキャンセルできるとき' do
    it '参加済のユーザーは詳細ページから参加をキャンセルできる' do
      # ログイン
      sign_in(@participant_user)
      # トレーニング詳細ページへ遷移
      visit training_path(@created_training)
      # トレーニング詳細ページにいることを確認
      expect(current_path).to eq training_path(@created_training)
      # 参加ボタンをクリック
      find('#join-training-path').click
      # コメントを入力し、送信をクリック
      fill_in 'comment', with: @ticket.comment
      click_on '送信'
      # キャンセルボタンが表示されていることを確認しクリック
      expect(page).to have_content('参加をキャンセル')
      click_on '参加をキャンセル'
      # キャンセル処理が完了し、ユーザー名が表示されていないことを確認
      expect(current_path).to eq training_path(@created_training)
      expect(page).to have_no_content(@participant_user.name)
    end
  end
  context '参加をキャンセルできないとき' do
    it '未参加のユーザーにはキャンセルボタンが表示されない' do
      # ログイン
      sign_in(@participant_user)
      # トレーニング詳細ページへ遷移
      visit training_path(@created_training)
      # トレーニング詳細ページにいることを確認
      expect(current_path).to eq training_path(@created_training)
      # キャンセルボタンが表示されていないことを確認
      expext(page).to have_no_content('参加をキャンセル')
    end
  end
end

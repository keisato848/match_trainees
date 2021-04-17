require 'rails_helper'

RSpec.describe 'retirements', type: :system do
  before do
    @owner = create(:owner)
  end

  context '退会できるとき' do
    it '公開中の未終了イベント、未終了の参加イベントが存在しないユーザーは退会できる' do
      # ログイン
      sign_in(@owner)
      # 退会ページへのリンクをクリック
      click_on '退会'
      # 退会ページへ遷移したことを確認
      expect(current_path).to eq new_retirement_path
      # 退会ボタンをクリック
      click_on '退会する'
      # トップページへ遷移したことを確認
      expect(current_path).to eq root_path
      # 退会完了メッセージが表示されていることを確認
      expect(page).to have_content('退会が完了しました')
    end
  end

  context '退会できないとき' do
    it '公開中の未終了イベントがあるユーザーは退会できない' do
      # ログイン
      sign_in(@owner)
      # 公開中の未終了イベントを作成
      @created_training = create(:training, owner: @owner, start_at: '2030-1-1-23-59', end_at: '2031-1-1-23-59')
      # 退会ページへのリンクをクリック
      click_on '退会'
      # 退会ページへ遷移したことを確認
      expect(current_path).to eq new_retirement_path
      # 退会ボタンをクリックしてもUserモデルのカウントが変わらないことを確認
      expect do
        click_on '退会する'
      end.to change { User.count }.by(0)
      # エラーメッセージが表示されていることを確認
      expect(page).to have_content('公開中の未終了イベントが存在します')
    end

    it '未終了の参加イベントがあるユーザーは退会できない' do
      # 主催者が公開中の未終了イベントを作成
      @created_training = create(:training, owner: @owner, start_at: '2030-1-1-23-59', end_at: '2031-1-1-23-59')
      # 参加者がログイン
      @participant_user = create(:user)
      sign_in(@participant_user)
      # トレーニング詳細ページへ遷移
      visit training_path(@created_training)
      # 参加ボタンをクリック
      find('#join-training-path').click
      # 送信をクリック
      click_on '送信'
      # 参加処理が完了し、詳細ページにリダイレクトされていることを確認
      expect(current_path).to eq training_path(@created_training)
      # 退会ページへのリンクをクリック
      click_on '退会'
      # 退会ページへ遷移したことを確認
      expect(current_path).to eq new_retirement_path
      # 退会ボタンをクリックしてもUserモデルのカウントが変わらないことを確認
      expect do
        click_on '退会する'
      end.to change { User.count }.by(0)
      # エラーメッセージが表示されていることを確認
      expect(page).to have_content('未終了の参加イベントが存在します')
    end
  end
end

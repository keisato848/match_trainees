require 'rails_helper'

RSpec.describe 'trainings', type: :system do
  before do
    @owner = create(:owner)
    @training = build(:training)
  end

  context 'トレーニングを作成できるとき' do
    it '正しい情報を入力すればトレーニングが作成できる' do
      # ログイン
      sign_in(@owner)
      # トレーニング作成ページへ遷移
      click_on '募集する'
      # トレーニング作成ページにいることを確認
      expect(current_path).to eq new_training_path
      # データをフォームに入力し、作成するをクリック
      fill_in 'name', with: @training.name
      select '北海道', from: 'training[prefecture_id]'
      fill_in 'place', with: @training.place
      select '2022', from: 'training[start_at(1i)]'
      select '12月', from: 'training[start_at(2i)]'
      select '31', from: 'training[start_at(3i)]'
      select '23', from: 'training[start_at(4i)]'
      select '58', from: 'training[start_at(5i)]'
      select '2022', from: 'training[end_at(1i)]'
      select '12月', from: 'training[end_at(2i)]'
      select '31', from: 'training[end_at(3i)]'
      select '23', from: 'training[end_at(4i)]'
      select '59', from: 'training[end_at(5i)]'
      fill_in 'content', with: @training.content
      click_on '作成する'
      # 詳細ページに作成した内容が表示されていることを確認
      expect(page).to have_content(@training.name)
      expect(page).to have_content('北海道')
      expect(page).to have_content(@training.place)
      expect(page).to have_content('2022/12/31 23:58')
      expect(page).to have_content('2022/12/31 23:59')
      expect(page).to have_content(@training.content)
    end
  end

  context 'トレーニングを編集できるとき' do
    it '作成したユーザーのみトレーニングを編集できる' do
      # trainingをDBに保存
      @training = create(:training, owner: @owner)
      # ログイン
      sign_in(@owner)
      # 詳細ページへ遷移
      visit training_path(@training.id)
      # 編集ページへのリンクをクリック
      click_on 'トレーニングを編集'
      # データをフォームに入力し、編集するをクリック
      @edited_training = build(:training)
      fill_in 'name', with: @edited_training.name
      select '東京都', from: 'training[prefecture_id]'
      fill_in 'place', with: @edited_training.place
      select '2022', from: 'training[start_at(1i)]'
      select '10月', from: 'training[start_at(2i)]'
      select '31', from: 'training[start_at(3i)]'
      select '23', from: 'training[start_at(4i)]'
      select '58', from: 'training[start_at(5i)]'
      select '2022', from: 'training[end_at(1i)]'
      select '10月', from: 'training[end_at(2i)]'
      select '31', from: 'training[end_at(3i)]'
      select '23', from: 'training[end_at(4i)]'
      select '59', from: 'training[end_at(5i)]'
      fill_in 'content', with: @edited_training.content
      click_on '編集する'
      # 詳細ページに編集した内容が表示されていることを確認
      expect(page).to have_content(@edited_training.name)
      expect(page).to have_content('東京都')
      expect(page).to have_content(@edited_training.place)
      expect(page).to have_content('2022/10/31 23:58')
      expect(page).to have_content('2022/10/31 23:59')
      expect(page).to have_content(@edited_training.content)
    end
  end

  context 'トレーニングを編集できないとき' do
    it '作成したユーザー以外はトレーニングを編集できない' do
      # trainingをDBに保存
      @training = create(:training, owner: @owner)
      # 作成者以外のユーザーがログイン
      @another_user = create(:user)
      sign_in(@another_user)
      # 詳細ページへ遷移
      visit training_path(@training.id)
      # 編集ページへのリンクが存在しないことを確認
      expect(page).to have_no_content 'トレーニングを編集'
    end
  end

  context 'トレーニングを削除できるとき' do
    it '自分が作成したトレーニングは削除できる' do
      # trainingをDBに保存
      @training = create(:training, owner: @owner)
      # ログイン
      sign_in(@owner)
      # 詳細ページへ遷移
      visit "trainings/#{@training.id}"
      # 削除を実行
      click_on 'トレーニングを削除'
      page.driver.browser.switch_to.alert.accept
      # トップページに遷移したことを確認
      expect(current_path).to eq root_path
      # 削除したトレーニングが表示されていないことを確認
      expect(page).to have_no_content @training.name
    end
  end
  context 'トレーニングを削除できないとき' do
    it '作成したユーザー以外はトレーニングを削除できない' do
      # trainingをDBに保存
      @training = create(:training, owner: @owner)
      # 作成者以外のユーザーがログイン
      @another_user = create(:user)
      sign_in(@another_user)
      # 詳細ページへ遷移
      visit training_path(@training.id)
      # 削除ボタンが存在しないことを確認
      expect(page).to have_no_content 'トレーニングを削除'
    end
  end
end

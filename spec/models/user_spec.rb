require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'ユーザー新規登録ができるとき' do
    it 'email、password、nameがあれば登録できる' do
      @user.provider = nil
      @user.uid = nil
      @user.image_url = nil
      expect(@user).to be_valid
    end
  end

  describe 'ユーザー新規登録ができないとき' do
    it 'emailがなければ登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
    end
    it 'passwordがなければ登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください', 'パスワードは不正な値です')
    end
    it 'passwordとpassword_confirmationが一致しなければ登録できない' do
      @user.password_confirmation = 'anotherpass1'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードの確認とパスワードの入力が一致しません')
    end
    it 'passwordは8文字以上でも半角数字のみでは登録できない' do
      @user.password = '12345678'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end
    it 'passwordは8文字以上でも半角英字のみでは登録できない' do
      @user.password = 'abcdefgh'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end
    it 'passwordは半角英数混合でも6文字未満では登録できない' do
      @user.password = '1234a'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end
    it 'nameがなければ登録できない' do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('ユーザー名を入力してください')
    end
    it '既存のnameは登録できない' do
      @user.save
      @another_user = build(:user, name: @user.name)
      @another_user.valid?
      expect(@another_user.errors.full_messages).to include('ユーザー名はすでに存在します')
    end
    it 'nameは40字以下でないと登録できない' do
      @user.name = 'あ' * 41
      @user.valid?
      expect(@user.errors.full_messages).to include('ユーザー名は40文字以内で入力してください')
    end
    it 'image_urlはhttpまたはhttpsを含まなければ登録できない' do
      @user.image_url = @user.image_url.gsub(/http/, '')
      @user.valid?
      expect(@user.errors.full_messages).to include('画像URLは不正な値です')
    end
  end
end

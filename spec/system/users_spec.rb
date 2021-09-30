require 'rails_helper'

RSpec.describe "ユーザー管理機能", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー登録できる場合' do
    it '全部正しく埋めていれば登録できる' do
      # トップページに移動する
      visit root_path
      # 自動的にログインページ。ログインページにいること確認
      visit new_user_registration_path
      # 情報を入力
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password
      # 登録ボタンを押すとレコードが１上がる
      expect{
        find('input[name="commit').click
      }.to change{User.count}.by(1)
      # トップページに飛ぶ
      expect(current_path).to eq(root_path)
      # ログアウトボタンがあること確認
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
      
    end
  end
  context 'ユーザー登録できない場合' do
    it '情報に不備があると登録できない' do
      # トップページに移動する
      visit root_path
      # 自動的にログインページ。ログインページにいること確認
      visit new_user_registration_path
      # 情報を入力
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password
      # 登録ボタンを押すとレコードが上がらない
      expect{
        find('input[name="commit').click
      }.to change{User.count}.by(0)
      # そのページに留まっている
      expect(current_path).to eq(user_registration_path)
    end
  end
  context 'ユーザーログイン' do
    it '正しく入力すればログインできる' do
      @user.save
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')

    end
    it '入力情報が間違っているとログインできない' do
      @user.save
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      find('input[name="commit').click
      expect(current_path).to eq(user_session_path)
    end
  end
end

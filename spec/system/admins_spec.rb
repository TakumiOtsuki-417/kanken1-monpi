require 'rails_helper'

RSpec.describe "管理者管理機能", type: :system do
  before do
    @admin = FactoryBot.build(:admin)
  end
  context '管理者として登録できる場合' do
    it '正しい情報を入力すれば登録できる' do
      # トップページに移動する
      visit root_path
      # 自動的にログインページ。ログインページにいること確認
      visit new_admin_registration_path
      # 情報を入力
      fill_in 'admin_nickname', with: @admin.nickname
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_password_confirmation', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      fill_in 'admin_code4', with: @admin.code4
      # 登録ボタンを押すとレコードが１上がる
      expect{
        find('input[name="commit').click
      }.to change{Admin.count}.by(1)
      # トップページに飛ぶ
      expect(current_path).to eq(root_path)
      # ログアウトボタンがあること確認
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context '登録に失敗する場合' do
    it '入力情報に不備があると登録できない' do
      # トップページに移動する
      visit root_path
      # 自動的にログインページ。ログインページにいること確認
      visit new_admin_registration_path
      # 情報を入力
      fill_in 'admin_nickname', with: @admin.nickname
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_password_confirmation', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      # 登録ボタンを押すとレコードが１上がる
      expect{
        find('input[name="commit').click
      }.to change{Admin.count}.by(0)
      # 同じページに留まる
      expect(current_path).to eq(admin_registration_path)
    end
  end
  context 'ログインに成功する場合' do
    it '正しく入力すればログインできる' do
      @admin.save
      visit root_path
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      fill_in 'admin_code4', with: @admin.code4
      find('input[name="commit').click
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')

    end
  end
  context 'ログインに失敗する場合' do
    it '入力が間違っているとログインできない' do
      @admin.save
      visit root_path
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      find('input[name="commit').click
      expect(current_path).to eq(admin_session_path)

    end
  end
end

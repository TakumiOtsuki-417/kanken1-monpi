require 'rails_helper'

RSpec.describe "記事管理機能", type: :system do
  before do
    @admin = FactoryBot.create(:admin)
    @user = FactoryBot.create(:user)
    @article = FactoryBot.build(:article)
  end
  context '管理者側の記事作成・閲覧・編集・削除機能' do
    it '管理者であれば記事作成・更新が可能である' do
      visit root_path
      # ログイン
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      fill_in 'admin_code4', with: @admin.code4
      find('input[name="commit').click
      # 新規記事作成ページへ
      visit new_article_path
      fill_in 'article_title', with: @article.title
      # iframe展開してbodyに要素追加(tinymce)
      within_frame('article_content_ifr') do
        element = find("body")
        element.native.send_keys("input sentence")
      end
      select '四字熟語', from: 'article_genre_id'
      select '門前眺めし者', from: 'article_rank_id'
      # 送信でデータ保存確認
      expect{
        find('input[name="commit"]').click
      }.to change{Article.count}.by(1)
      # 詳細ページへリダイレクトしたのを確認
      saved_article = Article.find_by(title: @article.title)
      expect(current_path).to eq(article_path(saved_article.id))
      visit edit_article_path(saved_article.id)
      new_title = 'sample_edit'
      fill_in 'article_title', with: new_title
      # 更新なのでカウントは増えないこと確認
      expect{
        find('input[name="commit"]').click
      }.to change{Article.count}.by(0)
      expect(current_path).to eq(article_path(saved_article.id))
      expect{
        find('a[id="btn-destroy"]').click
      }.to change{Article.count}.by(-1)
      expect(current_path).to eq(root_path)
    end
    it 'ユーザーは記事作成・更新はできない' do
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit').click
      visit new_article_path
      expect(current_path).to eq(root_path)
    end
  end
end

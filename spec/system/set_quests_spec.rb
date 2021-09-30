require 'rails_helper'

RSpec.describe "クエストセット機能", type: :system do
  before do
    @admin = FactoryBot.create(:admin)
    @article = FactoryBot.create(:article)
    @quest = FactoryBot.create(:quest, genre_id: @article.genre_id, rank_id: @article.rank_id)
    @user = FactoryBot.create(:user)
  end
  context 'クエストセットができる流れ' do
    it '選べばクエストセットできる' do
      visit root_path
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      fill_in 'admin_code4', with: @admin.code4
      find('input[name="commit').click
      visit new_article_quest_path(@article.id)
      select @quest.question, from: 'quest[quest_id]'
      expect{
        find('input[name="commit"]').click
      }.to change{ArticleQuest.count}.by(1)
      expect(current_path).to eq(article_quests_path(@article.id))

    end
  end
  context 'クエストセットに失敗する流れ' do
    it '選ばないとセットに失敗する' do
      visit root_path
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      fill_in 'admin_code4', with: @admin.code4
      find('input[name="commit').click
      visit new_article_quest_path(@article.id)
      expect{
        find('input[name="commit"]').click
      }.to change{ArticleQuest.count}.by(0)
      expect(page).to have_content("must exist")
    end
    it 'そもそもユーザーはセット管理をできない' do
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit').click
      visit new_article_quest_path(@article.id)
      expect(current_path).to eq(root_path)
    end
  end
  context 'クエストセットを解除する流れ' do
    it '解除ボタンでクエストセットを解除できる' do
      visit root_path
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      fill_in 'admin_code4', with: @admin.code4
      find('input[name="commit').click

      visit new_article_quest_path(@article.id)
      select @quest.question, from: 'quest[quest_id]'
      find('input[name="commit"]').click

      destroy_path = "#clear-#{@quest.id}"
      expect{
        find(destroy_path).click
      }.to change{ArticleQuest.count}.by(-1)
      expect(current_path).to eq(article_quests_path(@article.id))
    end
  end
end

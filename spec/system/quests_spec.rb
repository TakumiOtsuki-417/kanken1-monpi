require 'rails_helper'

RSpec.describe "問題管理機能", type: :system do
  before do
    @admin = FactoryBot.create(:admin)
    @quest = FactoryBot.build(:quest)
    @user = FactoryBot.create(:user)
end
  context '問題作成・編集・削除' do
    it '成功する流れ' do
      visit root_path
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      fill_in 'admin_code4', with: @admin.code4
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      
      visit new_makequest_path
      fill_in 'quest_question', with: @quest.question
      fill_in 'quest_select1', with: @quest.select1
      fill_in 'quest_select2', with: @quest.select2
      fill_in 'quest_select3', with: @quest.select3
      fill_in 'quest_select4', with: @quest.select4
      fill_in 'quest_answer', with: @quest.answer
      fill_in 'quest_explain', with: @quest.explain
      select '四字熟語', from: 'quest_genre_id'
      select '門前眺めし者', from: 'quest_rank_id'
      expect{
        find('input[name="commit"]').click
      }.to change{Quest.count}.by(1)
      expect(current_path).to eq(makequests_path)
      find('li[id="tab-0"]').click
      sleep 1.0  
      expect(page).to have_content(@quest.answer)  

      quest = Quest.find_by(question: @quest.question)
      visit edit_makequest_path(quest.id)
      new_question = "new question sentence!"
      fill_in 'quest_question', with: new_question
      expect{
        find('input[name="commit"]').click
      }.to change{Quest.count}.by(0)
      expect(current_path).to eq(makequests_path)
      find('li[id="tab-0"]').click
      sleep 1.0 
      num = Quest.count
      find_link('削除', href: makequest_path(quest.id)).click       
      page.driver.browser.switch_to.alert.accept
      find('li[id="tab-0"]').click
      sleep 1.0 
      expect(page).to have_no_content(@quest.answer)
      expect(Quest.count).to eq(num - 1)
    end
  end
  context '問題作成失敗' do
    it '入力内容に不備があると失敗する' do
      visit root_path
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      fill_in 'admin_code4', with: @admin.code4
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      
      visit new_makequest_path
      fill_in 'quest_select1', with: @quest.select1
      fill_in 'quest_select2', with: @quest.select2
      fill_in 'quest_select3', with: @quest.select3
      fill_in 'quest_select4', with: @quest.select4
      fill_in 'quest_answer', with: @quest.answer
      fill_in 'quest_explain', with: @quest.explain
      select '四字熟語', from: 'quest_genre_id'
      select '門前眺めし者', from: 'quest_rank_id'
      expect{
        find('input[name="commit"]').click
      }.to change{Quest.count}.by(0)
      expect(page).to have_content("お題の文章")
      expect(page).to have_content("can't be blank")
    end
    it 'そもそもユーザーは問題作成ができない' do
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit').click
      visit new_makequest_path
      expect(current_path).to eq(root_path)
    end
  end
  context '問題編集失敗' do
    it '編集内容に不備があると失敗する' do
      visit root_path
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_code1', with: @admin.code1
      fill_in 'admin_code2', with: @admin.code2
      fill_in 'admin_code3', with: @admin.code3
      fill_in 'admin_code4', with: @admin.code4
      find('input[name="commit"]').click
      
      visit new_makequest_path
      fill_in 'quest_question', with: @quest.question
      fill_in 'quest_select1', with: @quest.select1
      fill_in 'quest_select2', with: @quest.select2
      fill_in 'quest_select3', with: @quest.select3
      fill_in 'quest_select4', with: @quest.select4
      fill_in 'quest_answer', with: @quest.answer
      fill_in 'quest_explain', with: @quest.explain
      select '四字熟語', from: 'quest_genre_id'
      select '門前眺めし者', from: 'quest_rank_id'
      find('input[name="commit"]').click

      quest = Quest.find_by(question: @quest.question)
      visit edit_makequest_path(quest.id)
      new_question = ""
      fill_in 'quest_question', with: new_question
      find('input[name="commit"]').click
      expect(page).to have_content("お題の文章")
      expect(page).to have_content("can't be blank")
    end
  end
end

require 'rails_helper'

RSpec.describe "Scores", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
    @article = FactoryBot.create(:article, rank_id: @user.rank_id)
    @article2 = FactoryBot.create(:article, rank_id: @user.rank_id)
    @quest1 = FactoryBot.create(:quest, genre_id: @article.genre_id, rank_id: @article.rank_id)
    @quest2 = FactoryBot.create(:quest, genre_id: @article.genre_id, rank_id: @article.rank_id)
    @quest3 = FactoryBot.create(:quest, genre_id: @article.genre_id, rank_id: @article.rank_id)
    article_quest1 = ArticleQuest.create(article_id: @article.id, quest_id: @quest1.id)
    article_quest2 = ArticleQuest.create(article_id: @article.id, quest_id: @quest2.id)
    article_quest3 = ArticleQuest.create(article_id: @article.id, quest_id: @quest3.id)
    article_quest4 = ArticleQuest.create(article_id: @article2.id, quest_id: @quest1.id)
    article_quest5 = ArticleQuest.create(article_id: @article2.id, quest_id: @quest2.id)
    article_quest6 = ArticleQuest.create(article_id: @article2.id, quest_id: @quest3.id)
  end
  context 'スコアが登録されるまでの流れ' do
    it 'ユーザーなら問題を解くことでスコア登録できる' do
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit').click

      visit article_quests_path(@article.id)
      expect(page).to have_content("以下の問題に答えてください")
      expect(page).to have_content(@quest1.question)
      expect(page).to have_content(@quest2.question)
      expect(page).to have_content(@quest3.question)
      expect(page).to have_no_content("正解と解説")
      expect(page).to have_no_selector "#first-btn"
      radio1 = "score_update_select1_#{ @quest1.select2 }"
      radio2 = "score_update_select2_#{ @quest2.select2 }"
      radio3 = "score_update_select3_#{ @quest3.answer }"
      choose radio1
      choose radio2
      choose radio3

      sleep 0.5
      expect(page).to have_selector "#first-btn"
      click_on "回答する（正答を表示）"

      sleep 1.0
      expect(page).to have_content("正解と解説")
      expect(page).to have_no_selector "#first-btn"
      expect(page).to have_selector "#second-btn"
      expect{
        find('#second-btn').click
      }.to change{Score.count}.by(1)
      expect(current_path).to eq(root_path)
    end
  end
  context 'スコアが更新されるまでの流れ' do
    it '前回より正解率が高ければスコアが上書きされる' do
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit').click

      expect(current_path).to eq(root_path)
      score_id = "#score-#{ @article.id }"
      expect(page).to have_no_selector score_id

      #１度目
      visit article_quests_path(@article.id)
      radio1 = "score_update_select1_#{ @quest1.select2 }"
      radio2 = "score_update_select2_#{ @quest2.select2 }"
      radio3 = "score_update_select3_#{ @quest3.answer }"
      choose radio1
      choose radio2
      choose radio3
      sleep 0.5
      click_on "回答する（正答を表示）"
      sleep 1.0
      click_on "回答する"

      score1 = Score.find_by(article_id: @article.id, user_id: @user.id)
      total_score = "総合スコア：#{ score1.score }"
      score_text = "SCORE:#{ score1.score }"
      expect(page).to have_content(total_score)
      expect(page).to have_selector score_id, text: score_text

      #２度目
      visit article_quests_path(@article.id)
      radio1 = "score_update_select1_#{ @quest1.answer }"
      radio2 = "score_update_select2_#{ @quest2.answer }"
      choose radio1
      choose radio2
      choose radio3
      sleep 0.5
      click_on "回答する（正答を表示）"
      sleep 1.0
      click_on "回答する"
      score2 = Score.find_by(article_id: @article.id, user_id: @user.id)
      total_score = "総合スコア：#{ score2.score }"
      score_text = "SCORE:#{ score2.score }"
      expect(page).to have_content(total_score)
      expect(page).to have_selector score_id, text: score_text

      # 別の記事を回答
      visit article_quests_path(@article2.id)
      choose radio1
      choose radio2
      choose radio3
      sleep 0.5
      click_on "回答する（正答を表示）"
      click_on "回答する"
      sleep 1.0
      score3 = Score.find_by(article_id: @article2.id, user_id: @user.id)
      sleep 0.5 
      total_score = "総合スコア：#{ score2.score + score3.score }"
      expect(page).to have_content(total_score)
      

    end
  end
  context 'スコアが更新されない流れ（失敗ではない）' do
    it '前回より正解率が低ければ登録スコアに変化なし' do
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit').click

      expect(current_path).to eq(root_path)
      score_id = "#score-#{ @article.id }"
      expect(page).to have_no_selector score_id

      #１度目
      visit article_quests_path(@article.id)
      radio1 = "score_update_select1_#{ @quest1.answer }"
      radio2 = "score_update_select2_#{ @quest2.select2 }"
      radio3 = "score_update_select3_#{ @quest3.answer }"
      choose radio1
      choose radio2
      choose radio3
      sleep 0.5
      click_on "回答する（正答を表示）"
      sleep 1.0
      click_on "回答する"

      score1 = Score.find_by(article_id: @article.id, user_id: @user.id)
      score_text = "SCORE:#{ score1.score }"
      expect(page).to have_selector score_id, text: score_text

      #２度目
      visit article_quests_path(@article.id)
      radio1 = "score_update_select1_#{ @quest1.select2 }"
      radio2 = "score_update_select2_#{ @quest2.select2 }"
      radio3 = "score_update_select3_#{ @quest3.answer }"
      choose radio1
      choose radio2
      choose radio3
      sleep 0.5
      click_on "回答する（正答を表示）"
      sleep 1.0
      click_on "回答する"
      
      score2 = Score.find_by(article_id: @article.id, user_id: @user.id)
      score_text = "SCORE:#{ score1.score }"
      expect(page).to have_selector score_id, text: score_text

    end
  end

end

class QuestsController < ApplicationController
  before_action :redirect_user, except: [:index]

  def index
    @article = Article.find(params[:article_id])
    @article_quests = ArticleQuest.where(article_id: @article.id)
    @quests = []
    @article_quests.each do |article_quest|
      quest = Quest.find(article_quest.quest_id)
      @quests << quest
    end
    # ユーザーの場合にスコア既存チェック処理を行う
    if user_signed_in?
      score_exist_check
    end
    # 管理者の場合は問題数カウント処理
    if admin_signed_in?
      @quest_count = @article_quests.length
    end
  end
  def show
    @quest = Quest.find(params[:id])
  end
  def new
    @article_quest = ArticleQuest.new
    reset_article_info
  end
  def create
    @article_quest = ArticleQuest.new(quest_params)
    if @article_quest.save
      redirect_to article_quests_path(params[:article_id])
    else
      reset_article_info
      render :new
    end
  end
  def destroy
    article_id = params[:article_id]
    article_quest = ArticleQuest.find_by(quest_id: params[:id], article_id: article_id)
    article_quest.destroy
    redirect_to article_quests_path(article_id)
  end

  private

  def redirect_user
    if !admin_signed_in?
      redirect_to root_path
    end
  end
  def quest_params
    params.require(:quest).permit(:article_id, :quest_id)
  end
  def score_exist_check
    @score = ScoreUpdate.new
    score_exist_or_not = Score.find_by(user_id: current_user.id, article_id: @article.id)
    # 記事に紐づいたスコア記録がある場合
    unless score_exist_or_not.nil?
      @score_id = score_exist_or_not
      @rescore = ""
    end
  end
  def redirect_by_count
    article = Article.find(params[:article_id])
    article_quests = ArticleQuest.where(article_id: article.id)
    quest_count = article_quests.length
    if quest_count >= 100
      redirect_to article_quests_path(article.id)
    end
  end
  def reset_article_info
    @article = Article.find(params[:article_id])
    @genre = @article.genre_id
    @rank = @article.rank_id
    # テストジャンルの場合は全てのジャンル問題を取得。
    unless @genre == 5
      @select_quests = Quest.where(["genre_id = :genre_id and rank_id <= :rank_id", {genre_id: @genre, rank_id: @rank}])
    else
      @select_quests = Quest.where(["rank_id <= :rank_id", {rank_id: @rank}])
    end
  end
  

end

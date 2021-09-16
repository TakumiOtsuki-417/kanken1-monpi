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
    # ユーザーの場合に以下の処理を行う
    if user_signed_in?
      # 記事に紐づいたスコア記録がある場合
      unless Score.find_by(user_id: current_user.id, article_id: @article.id).nil?
        @score = ScoreUpdate.new
        @score_id = Score.find_by(user_id: current_user.id, article_id: @article.id)
        @rescore = ""
      # ない場合
      else
        @score = ScoreUpdate.new
      end
    end
    if admin_signed_in?
      #登録された問題数をカウント
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
    @select_quests = Quest.where(["genre_id = :genre_id and rank_id <= :rank_id", {genre_id: @genre, rank_id: @rank}])
  end

end

class QuestsController < ApplicationController
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
  end
  def show
    @quest = Quest.find(params[:id])
  end
  def new
    @article = Article.find(params[:article_id])
    genre = @article.genre
    level = @article.level
    @select_quests = Quest.where(["genre = :genre and level <= :level", {genre: genre, level: level}])
    
  end
  def create
    @article_quest = ArticleQuest.new(quest_params)
    if @article_quest.save
      redirect_to article_quests_path(params[:article_id])
    else
      render :new
    end
  end
  def destroy
    @article_quest = ArticleQuest.find(params[:id])
    article_id = @article_quest.article_id
    @article_quest.destroy
    redirect_to article_quests_path(article_id)
  end
    private

  def quest_params
    params.require(:quest).permit(:article_id, :quest_id)
  end

end

class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
      @genre_names = ['四字熟語', '故事・諺', '熟語訓・当て字', '読み取り', '書取り', '国字', '熟語と訓読み', '対義語・類義語', 'テスト']
    if user_signed_in?
      set_user_info
    elsif admin_signed_in?
      @articles = Article.all
      # 全てのレベル数値
      @all_rank = 5
    end
  end

  def show
    
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "新しい記事を作成しました" }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "記事の更新が完了しました" }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "記事を削除しました" }
      format.json { head :no_content }
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :rank_id, :genre_id)
    end

    def set_user_info
      @user = User.find(current_user.id)
      # スコアの計算
      @score = Score.where(user_id: @user.id)
      @total_score = 0
      @score.each do |score|
        @total_score += score.score
      end
      # ユーザーの状況に応じて記事の量を分ける
      @articles = Article.where('rank_id <= ?', @user.rank_id)
      # レベル数値
      @all_rank = @user.rank_id + 1
      @user_rank = Rank.find(@user.rank_id).name
    end
end

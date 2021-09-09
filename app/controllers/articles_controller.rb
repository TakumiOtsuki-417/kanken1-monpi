class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  # GET /articles or /articles.json
  def index
      @genre_names = ['四字熟語', '故事・諺', '熟語訓・当て字', '読み取り', '書取り', '国字', '熟語と訓読み', '対義語・類義語', 'テスト']
    if user_signed_in?
      @user = User.find(current_user.id)
      # スコアの計算
      @score = Score.where(user_id: @user.id)
      @total_score = 0
      @score.each do |score|
        @total_score += score.score
      end
      # ユーザーの状況に応じて記事の量を分ける
      @articles = Article.where('level <= ?', @user.rank_id)
      # レベル数値
      @all_rank = @user.rank_id + 1
      @user_rank = Rank.find(@user.rank_id).name
    elsif admin_signed_in?
      @articles = Article.all
      # 全てのレベル数値
      @all_rank = 5
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :rank_id, :genre_id)
    end
end

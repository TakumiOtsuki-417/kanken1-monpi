class ScoresController < ApplicationController
  before_action :set_instance
  before_action :score_params
  before_action :save_validates

  def create

  end
  def update

  end

  private
  def set_instance
    @user = User.find(current_user.id)
    @article = Article.find(params[:article_id])
  end
  def score_params
    @para = params.permit({score_update: {}}, :article_id).merge(user_id: current_user.id)
    @para_for_each = params.permit(score_update: {})[:score_update]
  end
  def save_validates
    @score_update = ScoreUpdate.new(@para)
    unless @score_update.valid?
      render 'quests/index'
    end
    # 現在のアクション名を定義
    is_create = nil
    if controller_path == 'scores' && action_name == 'create'
      is_create = true
    else
      is_create = false
    end
    @score_update.save(@para, is_create)
    redirect_to root_path    
  end
  def calculate_score
    article_quests = ArticleQuest.where(article_id: @article.id)
    quests = []
    article_quests.each do |article_quest|
      quest = Quest.find(article_quest.quest_id)
      quests << quest
    end
    # 正解しているかどうかを判定する繰り返し処理
    correct = 0
    num = 0
    @para_for_each.values.each do |select|
      # 送られた選択肢の値と問題文の正答が一致する場合
      if select.eql?(quests[num][:answer])
        # 正解数をカウント
        correct += 1
      else
        # 不正解の場合、ユーザーと問題を結びつける
        user_quest = UserQuest.find_by(user_id: @user.id, quest_id: quests[num].id)
        # その組み合わせが登録されてない場合
        if user_quest.nil?
        # repeat:1の中間データを新しく保存する
          UserQuest.create(user_id: @user.id, quest_id: quests[num].id, repeat: 1)
        # 既にその組み合わせが登録されている場合
        else
          repeat = user_quest.repeat + 1
          # repeatを1増やして更新する(新しく記事問題に挑戦する場合でもリピートがありうるため)
          user_quest.update(user_id: @user.id, quest_id: quests[num].id, repeat: repeat)
        end
      end
      num += 1
    end
    # 点数＝（正解数÷問題数）＊１００
    @article_score = (correct.to_f / quests.length.to_f * 100).round
  end
  def calculate_rank
      # 総合スコアを計算
      scores = Score.where(user_id: @user.id)
      @total_score = 0
      scores.each do |score|
        @total_score += score.score
      end
      # テストの合格数を計算（７０点以上）
      test_article = Article.where(genre: 2)
      @test_ok = 0
      test_article.each do |ta|
        ta_score = Score.find_by(user_id: current_user.id, article_id: ta.id)
        unless ta_score.nil?
          if ta_score.score >= 70
            @test_ok += 1
          end
        end
      end
      # テストの合格数と総合スコアによって称号分け（これは得点が下回るケースを除外しているのでOK）
      @rank = 0
      # 現在保存されているランクよりも上であれば上書き
        @user = User.find(current_user.id)
      if @rank > @user.rank_id
        @user.update(rank_id: @rank)
      end
  end
  def case_rank
    case @total_score
      when 0..279
        @rank = 1
      when 280..619
        if @test_ok >= 0
          @rank = 2
        end
      when 620..nil
        if @test_ok >= 2
          @rank = 3
        end
      else
    end
  end
end

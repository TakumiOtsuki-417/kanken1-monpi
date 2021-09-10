class ScoreUpdate

  include ActiveModel::Model
  
  101.times do |i|
    attr_accessor "select#{i}"
  end
  attr_accessor :article_id
  attr_accessor :user_id
  attr_accessor :score_update

  # バリデーションを記述
  with_options presence: true do
    validates :score_update
    validates :article_id
    validates :user_id
  end


  def save(params, is_create)
    # 二度手間な気もするセット
    @user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    @para = params.permit({score_update: {}}, :article_id)
    @para_for_each = params.permit(score_update: {})[:score_update]
    # 以下、本番
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

    #ここで、createアクションとupdateアクションの場合分けを行いたい
    if is_create == true
      #createアクションにおけるscore保存処理
      # 点数を保存（記事とユーザーの中間データ保存）
      save_score = Score.create(user_id: @user.id, article_id: @article.id, score: @article_score)
    elsif is_create == false
      # updateアクションにおけるscore保存処理
      # 点数を保存（記事とユーザーの中間データ保存）
      update_score = Score.find_by(user_id: @user.id, article_id: @article.id)
      saved_score = update_score.score
      # 形式的に保存でき、かつ点数が過去より上回ってる場合
      if @article_score > saved_score
        update_score.update(user_id: @user.id, article_id: @article.id, score: @article_score)
        # リダイレクトする前に、称号の更新可能性を計算
        calculate_rank
      # 今回点数が下回ってた場合
      else
        return
      end
    else
      puts "何でやねん"
      binding.pry
      return
    end
  end

  private

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
      ta_score = Score.find_by(user_id: @user.id, article_id: ta.id)
      unless ta_score.nil?
        if ta_score.score >= 70
          @test_ok += 1
        end
      end
    end
    # テストの合格数と総合スコアによって称号分け（これは得点が下回るケースを除外しているのでOK）
    @rank = 0
    case @total_score
      when 100..279
        @rank = 1
      when 280..619
        if @test_ok >= 0
          @rank = 2
        end
      when 620..1199
        if @test_ok >= 2
          @rank = 3
        end
      when 1200..nil
        if @test_ok >= 3
          @rank = 4
        end
      else
    end
    # 現在保存されているランクよりも上であれば上書き
    @user = User.find(@user.id)
    if @rank > @user.rank_id
      @user.update(rank_id: @rank)
    end
  end

end
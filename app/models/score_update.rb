class ScoreUpdate

  include ActiveModel::Model
  
  101.times do |i|
    attr_accessor "select#{i}"
  end
  attr_accessor :article_id
  attr_accessor :user_id
  attr_accessor :score_update

  # saveまたはupdateするメソッド
  def save(params, is_create)
    @user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    @para_for_each = params.permit(score_update: {})[:score_update]
    # 以下、本番

    update_repeat
    
    #createアクションにおけるscore保存処理
    if is_create == true
      # 点数を保存（記事とユーザーの中間データ保存）
      save_score = Score.create(user_id: @user.id, article_id: @article.id, score: @article_score)
      # リダイレクトする前に、称号の更新可能性を計算
      calculate_rank
    # updateアクションにおけるscore保存処理
    elsif is_create == false
      # 点数を保存（記事とユーザーの中間データ保存）
      update_score = Score.find_by(user_id: @user.id, article_id: @article.id)
      saved_score = update_score.score
      # 形式的に保存でき、かつ点数が過去より上回ってる場合
      if @article_score > saved_score
        update_score.update(user_id: @user.id, article_id: @article.id, score: @article_score)
        # リダイレクトする前に、称号の更新可能性を計算
        calculate_rank
      # 今回点数が下回ってた場合（score更新なし）
      else
        return
      end
    else
      return
    end
  end

  private
  # 問題の正解かどうかを記録するメソッド
  def update_repeat
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
  # ランクを計算するメソッド
  def calculate_rank
    scores = Score.where(user_id: @user.id)
    @total_score = 0
    scores.each do |score|
      @total_score += score.score
    end
    # テストの合格数を計算（７０点以上）
    test_article = Article.where(genre_id: 5)
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
    case @test_ok
      when 0
        @rank = 0
      when 1
        #記事数11
        judge_score(1, 11, 70)
      when 2
        #記事数23
        judge_score(2, 23, 70)
      when 3
        #記事数35
        judge_score(3, 35, 70)
      when 4
        #記事数47
        judge_score(4, 47, 80)
      when 5
        @rank = 4
      else

    end
    # 現在保存されているランクよりも上であれば上書き
    @user = User.find(@user.id)
    if @rank > @user.rank_id
      @user.update(rank_id: @rank)
    end
  end

  def judge_score(judge_rank, article_num, ok_line)
    max_score = article_num * 100
    rate = (ok_line * 0.01).round(2)
    if @total_score >= (max_score * rate)
      @rank = judge_rank
    end
  end

end
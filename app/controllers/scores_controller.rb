class ScoresController < ApplicationController
  before_action :save_validates

  def create

  end
  def update

  end

  private
  def save_validates
    @para = params.permit({score_update: {}}, :article_id).merge(user_id: current_user.id)
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
end

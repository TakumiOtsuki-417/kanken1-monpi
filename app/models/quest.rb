class Quest < ApplicationRecord

  # バリデーション
  with_options presence: true do
    validates :question
    validates :select1
    validates :select2
    validates :select3
    validates :select4
    validates :answer
    validates :explain
    validates :genre_id
    validates :rank_id
  end

  # アソシエーション
  has_many :article_quests
  has_many :articles, through: :article_quest
  has_many :user_quests
  has_many :users, through: :user_quest
end

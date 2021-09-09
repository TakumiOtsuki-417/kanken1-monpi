class Article < ApplicationRecord

  # バリデーション

  with_options presence: true do
    validates :title
    validates :content
    validates :genre_id
    validates :rank_id
  end

  # アソシエーション
  has_many :article_quests
  has_many :quests, through: :article_quest
  has_many :scores
  has_many :users, through: :score
end

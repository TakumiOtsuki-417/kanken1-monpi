class Article < ApplicationRecord
  # アソシエーション
  has_many :article_quests
  has_many :quests, through: :article_quest
  has_many :scores
  has_many :users, through: :score
end

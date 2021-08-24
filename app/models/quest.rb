class Quest < ApplicationRecord
  # アソシエーション
  has_many :article_quests
  has_many :articles, through: :article_quest
  has_many :user_quests
  has_many :users, through: :user_quest
end

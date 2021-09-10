class Article < ApplicationRecord

  # バリデーション

  with_options presence: true do
    validates :title
    validates :content
    with_options format: {with: /\A[0-9]+\z/, message: "is invalid. Input only half-number"} do
      validates :genre_id, numericality: { less_than_or_equal_to: 8, message: "must be less than or equal to 8" }
      validates :rank_id
    end
  end

  # アソシエーション
  has_many :article_quests
  has_many :quests, through: :article_quest
  has_many :scores
  has_many :users, through: :score
end

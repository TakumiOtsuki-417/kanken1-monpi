class Article < ApplicationRecord

  # バリデーション

  with_options presence: true do
    validates :title
    validates :content, length: {maximum: 4294967295, messages: "is too long."}
    with_options numericality: {only_integer: true, message: "is invalid. Input only half-number"} do
      validates :genre_id
      validates :rank_id
    end
  end
  validates :genre_id, numericality: {less_than_or_equal_to: 5, message: 'is invalid. Input less than 6'}
  validates :rank_id, numericality: {less_than_or_equal_to: 4, message: 'is invalid. Input less than 5'}
  # アソシエーション
  has_many :article_quests
  has_many :quests, through: :article_quest
  has_many :scores
  has_many :users, through: :score
end

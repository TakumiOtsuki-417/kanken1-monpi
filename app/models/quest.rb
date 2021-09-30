class Quest < ApplicationRecord

  # バリデーション
  selects = [:select1, :select2, :select3, :select4]
  with_options presence: true do
    validates :question
    validates :select1
    validates :select2
    validates :select3
    validates :select4
    validates :answer
    validates :explain
    with_options numericality: {only_integer: true, message: "is invalid. Input only half-number"} do
      validates :genre_id
      validates :rank_id
    end
  end
  validates :genre_id, numericality: {less_than_or_equal_to: 5, message: 'is invalid. Input less than 6'}
  validates :rank_id, numericality: {less_than_or_equal_to: 4, message: 'is invalid. Input less than 5'}
  validate :add_errors

  # アソシエーション
  has_many :article_quests
  has_many :articles, through: :article_quest
  has_many :user_quests
  has_many :users, through: :user_quest

  def add_errors
    unless [select1, select2, select3, select4].include?(answer)
      errors[:base] << "Answer must be the same string as one of 4 selects." 
    end
  end
end

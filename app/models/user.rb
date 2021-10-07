class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    # バリデーション

    with_options presence: true do
      validates :nickname
      validates :email
      validates :password, on: :create
      validates :rank_id
    end
    validates :rank_id, numericality: {only_integer: true, message: 'is invalid. Input only half-number'}
    validates :rank_id, numericality: {less_than_or_equal_to: 4, message: 'is invalid. Input less than 5'}

    # アソシエーション
    has_many :scores
    has_many :articles, through: :score
    has_many :user_quests
    has_many :quests, through: :user_quest

    # アソシエーション（ActiveHash）
    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :rank
end

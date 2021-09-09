class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    # バリデーション

    with_options presence: true do
      validates :nickname
      validates :email
      validates :password
      validates :rank_id
    end

    # アソシエーション
    has_many :scores
    has_many :articles, through: :score
    has_many :user_quests
    has_many :quests, through: :user_quest

    # アソシエーション（ActiveHash）
    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :rank
  end

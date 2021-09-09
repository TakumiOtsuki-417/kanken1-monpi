class UserQuest < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :quest
end

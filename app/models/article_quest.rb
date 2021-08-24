class ArticleQuest < ApplicationRecord
  # アソシエーション
  belongs_to :article
  belongs_to :quest
end

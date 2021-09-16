class Rank < ActiveHash::Base

  self.data = [
    { id: 0, name: '門前眺めし者' },
    { id: 1, name: '大夢見ゆる者' },
    { id: 2, name: '踏み込む者' },
    { id: 3, name: '叩きし者' },
    { id: 4, name: '開かれし者' },
    { id: 5, name: 'その先へ' },
  ]

  # アソシエーション
  include ActiveHash::Associations
  has_many :users

end
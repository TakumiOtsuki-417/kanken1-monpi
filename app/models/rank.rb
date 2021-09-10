class Rank < ActiveHash::Base

  self.data = [
    { id: 0, name: '入門者' },
    { id: 1, name: '序の口' },
    { id: 2, name: 'まだまだ初心者' },
    { id: 3, name: 'ようこそ中級' },
    { id: 4, name: 'まだまだ中級' },
    { id: 5, name: '希望は見えてきた？' },
  ]

  # アソシエーション
  include ActiveHash::Associations
  has_many :users

end
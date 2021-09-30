class Genre < ActiveHash::Base

  self.data = [
    { id: 0, name: '四字熟語' },
    { id: 1, name: '故事・諺' },
    { id: 2, name: '当て字' },
    { id: 3, name: '読み取り/書き取り' },
    { id: 4, name: '対義語・類義語' },
    { id: 5, name: 'テスト' }
  ]

end
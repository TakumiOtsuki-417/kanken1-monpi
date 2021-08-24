class Rank < ActiveHash::Base

  self.data = [
    { id: 0, name: '四字熟語' },
    { id: 1, name: '故事・諺' },
    { id: 2, name: '熟語訓・当て字' },
    { id: 3, name: '読み取り' },
    { id: 4, name: '書取り' },
    { id: 5, name: '国字' },
    { id: 6, name: '熟語と訓読み'},
    { id: 7, name: '対義語・類義語' },
    { id: 8, name: 'テスト' }
  ]

end
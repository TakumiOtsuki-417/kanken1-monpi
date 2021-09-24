FactoryBot.define do
  factory :quest do
    question {Faker::Lorem.sentence}
    select1 {Faker::Lorem.word}
    select2 {Faker::Lorem.word}
    select3 {Faker::Lorem.word}
    select4 {Faker::Lorem.word}
    answer { select1 }
    explain {Faker::Lorem.paragraphs}
    genre_id {Faker::Number.between(from: 0, to: 8)}
    rank_id {Faker::Number.between(from: 0, to: 4)}
  end
end

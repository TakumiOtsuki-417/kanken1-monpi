FactoryBot.define do
  factory :quest do
    question {Faker::Lorem.sentence}
    select1 {"選択肢１"}
    select2 {"選択肢２"}
    select3 {"選択肢３"}
    select4 {"選択肢４"}
    answer { select1 }
    explain {Faker::Lorem.paragraphs}
    genre_id {Faker::Number.between(from: 0, to: 5)}
    rank_id {Faker::Number.between(from: 0, to: 4)}
  end
end

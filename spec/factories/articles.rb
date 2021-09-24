FactoryBot.define do
  factory :article do
    title {Faker::Lorem.sentence}
    content {Faker::Lorem.paragraphs}
    genre_id {Faker::Number.between(from: 0, to: 8)}
    rank_id {Faker::Number.between(from: 0, to: 4)}
  end
end

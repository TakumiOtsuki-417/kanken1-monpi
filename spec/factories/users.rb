FactoryBot.define do
  factory :user do
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    nickname {Faker::Name.name}
    rank_id {Faker::Number.between(from: 0, to: 4)}
  end
end

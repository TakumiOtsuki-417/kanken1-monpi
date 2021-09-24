FactoryBot.define do
  factory :admin do
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    nickname {Faker::Name.name}
    code1 {ENV['MONPI_ADMIN_AUTH_CODE1']}
    code2 {ENV['MONPI_ADMIN_AUTH_CODE2']}
    code3 {ENV['MONPI_ADMIN_AUTH_CODE3']}
    code4 {ENV['MONPI_ADMIN_AUTH_CODE4']}
  end
end

FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password_digest { "asdf1234" }
    api_key { SecureRandom.hex(16) }
    account_title { "Test Account" }
  end
end

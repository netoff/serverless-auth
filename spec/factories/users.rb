FactoryBot.define do
  factory :user do
    account { create(:account) }
    email { "MyString" }
    password_digest { "MyString" }
    data { "" }
    subscribed { false }
    plan_id { "MyString" }
    stripe_id { "MyString" }
  end
end

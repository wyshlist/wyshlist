FactoryBot.define do
  factory :vote do
    wish { association(:wish) }
    user { association(:record_owner_user) }
  end
end

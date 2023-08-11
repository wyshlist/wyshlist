FactoryBot.define do
  factory :wish do
    title { "My wish" }
    description { "The description of my wish" }
    user { association(:record_owner_user) }
    wishlist { association(:wishlist) }
  end
end

FactoryBot.define do
  factory :wishlist do
    title { "My wyshlist" }
    description { "The description of my wyshlist" }
    user { association(:team_member) }
  end
end

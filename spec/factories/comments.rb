FactoryBot.define do
  factory :comment do
    content { "This is a comment" }
    user { association(:record_owner_user) }
    wish { association(:wish) }
  end
end

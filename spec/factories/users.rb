FactoryBot.define do
  factory :record_owner_user, class: User do
    sequence(:email) { |n| "user#{n}@wyshlist" }
    password { "123123" }
    first_name { "user1" }
    last_name { "user1" }
  end

  factory :no_record_owner_user, class: User do
    email { "user1@gmail.com" }
    password { "123123" }
    first_name { "user2" }
    last_name { "user2" }
  end

  factory :super_team_member, class: User do
    email { "super_team_member@wyshlist.com" }
    password { "123123" }
    first_name { "super_team_member" }
    last_name { "super_team_member" }
    role { "super_team_member" }
    organization { association(:organization) }
  end

  factory :team_member, class: User do
    sequence(:email) { |n| "team_member#{n}@wyshlist" }
    password { "123123" }
    first_name { "team_member" }
    last_name { "team_member" }
    role { "team_member" }
    organization { association(:organization) }
  end

  factory :admin, class: User do
    email { "admin@wyshlist.com" }
    password { "123123" }
    first_name { "admin" }
    last_name { "admin" }
    role { "admin" }
  end
end

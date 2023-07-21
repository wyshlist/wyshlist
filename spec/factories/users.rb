FactoryBot.define do
  factory :record_owner_user, class: User do
    email { "user1@gmail.com" }
    password { "123123" }
    username { "user1" }
  end

  factory :no_record_owner_user, class: User do
    email { "user1@gmail.com" }
    password { "123123" }
    username { "user1" }
  end

  factory :super_team_member, class: User do
    email { "super_team_member@wyshlist.com" }
    password { "123123" }
    username { "super_team_member" }
    role { "super_team_member" }
    organization { association(:organization) }
  end

  factory :team_member, class: User do
    email { "team_member@wyshlist.com" }
    password { "123123" }
    username { "team_member" }
    role { "team_member" }
    organization { association(:organization) }
  end

  factory :admin, class: User do
    email { "admin@wyshlist.com" }
    password { "123123" }
    username { "admin" }
    role { "admin" }
  end
end

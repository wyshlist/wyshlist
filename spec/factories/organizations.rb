FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "Organization #{n}" }
    sequence(:subdomain) { |n| "organization_#{n}" }
  end
end

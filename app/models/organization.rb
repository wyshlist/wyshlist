class Organization < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :wishlists, dependent: :destroy
    has_many :wishes, through: :wishlists
    validates :name, presence: true, uniqueness: true
    before_save :titleize_name
    has_one_attached :logo

    def titleize_name
        self.name = self.name.titleize
    end

    def organization_owner?(user)
      users.first == user
    end

    def organization_member?(user)
      users.include?(user)
    end

    def subdomain
      self.name.gsub(" ", "_").downcase
    end
end

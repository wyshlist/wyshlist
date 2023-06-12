class Organization < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :wishlists, dependent: :destroy
    validates :name, presence: true, uniqueness: true
    before_save :titleize_name
    has_one_attached :logo
    COLORS = ["ECEDFE", "EFFEEC", "FEFCEC", "FEECEC", "F9ECFE", "ECFEFE"]

    def titleize_name
        self.name = self.name.titleize
    end

    def organization_owner?(user)
        users.first == user
    end
end

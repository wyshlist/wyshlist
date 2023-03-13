class Organization < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :wishlists, through: :users
    validates :name, presence: true, uniqueness: true
    before_save :titleize_name

    def titleize_name
        self.name = self.name.titleize
    end
end

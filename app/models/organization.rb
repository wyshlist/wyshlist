class Organization < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :wishlists, through: :users
    validates :name, presence: true, uniqueness: true
end

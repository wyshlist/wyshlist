class Organization < ApplicationRecord
    has_many :users, dependent: :destroy
    has_many :wishlists, through: :users
end

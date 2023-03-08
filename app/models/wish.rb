class Wish < ApplicationRecord
  belongs_to :wishlist
  validates :title, presence: true
  validates :description, presence: true
  has_many :votes, dependent: :destroy
end

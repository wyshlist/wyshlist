class Wishlist < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  has_many :wishes, dependent: :destroy
end

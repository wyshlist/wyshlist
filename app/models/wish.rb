class Wish < ApplicationRecord
  belongs_to :wishlist
  validates :title, presence: true
  validates :description, presence: true
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
  belongs_to :user
  has_many :comments, dependent: :destroy
end

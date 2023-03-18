class Wish < ApplicationRecord
  belongs_to :wishlist
  validates :title, presence: true
  validates :description, presence: true
  has_many :votes, dependent: :destroy
  has_many :users
  belongs_to :user
  has_many :comments, dependent: :destroy
  enum status: { "Backlog": 0, "In process": 1, "In review": 2, "Beta": 3, "launched": 4 }
  # after_create_commit { broadcast_append_to "wishes" }
end

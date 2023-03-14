class Wish < ApplicationRecord
  belongs_to :wishlist
  validates :title, presence: true
  validates :description, presence: true
  has_many :votes, dependent: :destroy
  has_many :users
  belongs_to :user
  has_many :comments, dependent: :destroy
  enum status: { backlog: 0, in_process: 1, in_review: 2, beta: 3, launched: 4 }
end

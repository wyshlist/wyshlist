class Integration < ApplicationRecord
  belongs_to :wishlist
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :wishlist }
  validates :api_token, presence: true
  APPS = %w[Asana]
  ACTIONS = ["Create a new task"]
end

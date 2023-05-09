class Wishlist < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  has_many :wishes, dependent: :destroy
  COLORS = ["ECEDFE", "EFFEEC", "FEFCEC", "FEECEC", "F9ECFE", "ECFEFE"]

  def self.sorted_by_votes
    order('votes_count DESC')
  end
end

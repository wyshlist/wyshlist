class Wishlist < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  has_many :wishes, dependent: :destroy

  COLORS = ["ECEDFE", "EFFEEC", "FEFCEC", "FEECEC", "F9ECFE", "ECFEFE"]

  def admin_wishlist?
    status == "admin"
  end

  def self.admin_wishlists
    Wishlist.where(status: "admin")
  end
end

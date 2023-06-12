class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :organization, optional: true
  validates :title, presence: true
  validates :description, presence: true
  has_many :wishes, dependent: :destroy
  has_many :integrations, dependent: :destroy


  def admin_wishlist?
    status == "admin"
  end

  def self.admin_wishlists
    Wishlist.where(status: "admin")
  end

  def asana_integration
    integrations.find_by(name: "Asana")
  end
end

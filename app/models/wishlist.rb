class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :organization, optional: true
  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true
  has_many :wishes, dependent: :destroy
  has_many :integrations, dependent: :destroy

  COLORS = ["ECEDFE", "EFFEEC", "FEFCEC", "FEECEC", "F9ECFE", "ECFEFE"]

  def admin_wishlist?
    status == "admin"
  end

  # rubocop:disable Naming/PredicateName
  def has_an_organization?
    !organization.nil?
  end
  # rubocop:enable Naming/PredicateName

  def self.admin_wishlists
    Wishlist.where(status: "admin")
  end

  def asana_integration
    integrations.find_by(name: "Asana")
  end
end

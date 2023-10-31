class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :wishes, through: :wishlists
  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true, format: { with: /\A[\w\-]+\z/ }
  before_save :titleize_name
  after_create :create_subdomain
  after_destroy :delete_subdomain
  has_one_attached :logo

  def titleize_name
    self.name = name.titleize
  end

  def organization_owner?(user)
    users.first == user
  end

  def organization_member?(user)
    users.include?(user)
  end

  private

  def delete_subdomain
    HerokuApi::SubdomainDeletor.new(subdomain).call if Rails.env.production?
  end

  def create_subdomain
    HerokuApi::SubdomainCreator.new(subdomain).call if Rails.env.production?
  end
end

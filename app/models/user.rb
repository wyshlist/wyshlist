class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :wishlists, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :wishes, through: :votes
  has_many :comments, dependent: :destroy
  belongs_to :organization, optional: true

  def has_an_organization?
    !organization.nil?
  end

  def owner?(wishlist)
    wishlist.user == self
  end

  def all_wishlists
    wishlists + organization.wishlists + votes.map(&:wish).map(&:wishlist)
  end
end

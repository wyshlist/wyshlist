class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :wishlists, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :organization, optional: true
  has_one_attached :photo
  enum :role => [:user, :admin]


  def has_an_organization?
    !organization.nil?
  end

  def admin?
    role == "admin"
  end

  def photo_attached?
    photo.attached?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def owner?(wishlist)
    wishlist.user == self
  end

  def all_wishlists
    if has_an_organization?
      votes_wishlists = votes.includes(wish: :wishlist).map(&:wish).map(&:wishlist)
      relation = Wishlist.where(id: votes_wishlists).or(Wishlist.where(id: wishlists.map(&:id))).or(Wishlist.where(user: organization.users))
    else
      votes_wishlists = votes.includes(wish: :wishlist).map(&:wish).map(&:wishlist)
      relation = Wishlist.where(id: votes_wishlists).or(Wishlist.where(id: wishlists.map(&:id)))
      
    end
  end
end

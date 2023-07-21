class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :wishlists, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :organization, optional: true
  has_one_attached :photo
  enum :role => [:user, :team_member, :admin]
  after_create :signup_email

  def is_team_member?
    team_member_since.present?
  end

  def is_user?
    user_since.present?
  end

  def has_an_organization?
    !organization.nil?
  end

  def team_members
    organization.users unless organization.nil?
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

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data['name'],
           first_name: data['first_name'],
           last_name: data['last_name'],
           email: data['email'],
           photo: data['image'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
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
  
  private

  def signup_email
    UserMailer.with(user: self).signup_email.deliver_now 
  end 
end

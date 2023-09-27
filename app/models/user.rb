class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :wishlists, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :organization, optional: true
  has_one_attached :photo
  enum :role => [:user, :super_team_member, :team_member, :admin]
  after_create :signup_email

  def is_admin?
    role == "admin"
  end

  def is_team_member?
    role == "team_member"
  end

  def is_regular_user?
    role == "user"
  end

  def is_super_team_member?
    role == "super_team_member"
  end

  def is_owner_of(record)
    record.user == self
  end

  def is_team_member_of(organization)
    self.organization == organization
  end

  def has_an_organization?
    !organization.nil?
  end

  def team_members
    organization.users unless organization.nil?
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

  def initial
    first_name[0].upcase + last_name[0].upcase
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
           first_name: data['first_name'],
           last_name: data['last_name'],
           email: data['email'],
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

  def invite!(email, name)
    super
    self.organization = self.invited_by.organization
    self.role = 'team_member'
    self.save
  end

  def invitation_status
    if self.invited_by_type == 'User'
      return 'Invitation Sent' if self.invitation_accepted_at.nil?
      return 'Accepted' if invitation_accepted_at
    else
      return '-'
    end
  end

  private

  def signup_email
    UserMailer.with(user: self).signup_email.deliver_now
  end
end

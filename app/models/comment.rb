class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :wish
  validates :content, presence: true, length: { minimum: 5, maximum: 500 }

  def from_team?(organization)
    user.organization == organization
  end
end

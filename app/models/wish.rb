class Wish < ApplicationRecord
  belongs_to :wishlist
  validates :title, presence: true
  has_many :votes, dependent: :destroy
  has_many :users
  belongs_to :user
  has_rich_text :description
  has_many :comments, dependent: :destroy
  enum stage: { "Backlog": 0, "In process": 1, "In review": 2, "Beta": 3, "launched": 4 }
  # after_create_commit { broadcast_append_to "wishes" }

  def user_vote(user)
    votes.find_by(user: user)
  end

  def self.sorted_by_votes
    left_joins(:votes)
      .group(:id)
      .order('COUNT(votes.id) DESC')
  end

  def stage_color
    case stage
      when "Backlog" then "#F9ECFE"
      when "In process" then "#ECFEFE"
      when "In review" then "#ECEDFE"
      when "Beta" then "#FEFCEC"
      when "Launched" then "#EFFEEC"
    end
  end
end

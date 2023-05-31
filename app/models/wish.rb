require_relative '../services/asana_api/asana_client'
class Wish < ApplicationRecord
  belongs_to :wishlist
  validates :title, presence: true
  has_many :votes, dependent: :destroy
  # has_many :users
  belongs_to :user
  has_rich_text :description
  has_many :comments, dependent: :destroy
  enum stage: { "Backlog": 0, "In process": 1, "In review": 2, "Beta": 3, "launched": 4 }
  after_create :send_to_asana, if: :asana_integration?
  # after_create_commit { broadcast_append_to "wishes" }
  after_update :create_comment
  after_create :upvote

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

  def create_comment
    if saved_change_to_stage?
      Comment.create(content: "The stage of this ticket has been updated to: #{stage}", user: user, wish: self)
    end
  end
        
 private

  def asana_integration?
    wishlist.integrations.find_by(name: "Asana").present?
  end

  def send_to_asana
    asana = wishlist.asana_integration
    AsanaApi::SendTask.new(asana.api_token).call(asana.workspace, asana.project, title, description.to_plain_text)
  end
 
  def upvote
    Vote.create!(wish: self, user: self.user)
  end
end

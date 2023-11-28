require_relative '../services/asana_api/asana_client'
class Wish < ApplicationRecord
  belongs_to :wishlist
  has_one :organization, through: :wishlist
  validates :title, presence: true
  has_many :votes, dependent: :destroy
  belongs_to :user
  has_rich_text :description
  has_many :comments, dependent: :destroy

  enum stage: { Backlog: 0, 'In process': 1, 'In review': 2, Beta: 3, Launched: 4 }
  after_create :send_to_asana, if: :asana_integration?
  # after_create_commit { broadcast_append_to "wishes" }
  after_update :create_comment, if: :saved_change_to_stage?
  after_create :upvote

  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
                  against: %i[title],
                  associated_against: {
                    rich_text_description: %i[body]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :search_by_board_name,
                  associated_against: {
                    wishlist: %i[title]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  def user_vote(user)
    votes.find_by(user:)
  end

  def stage_color
    case stage.capitalize
    when "Backlog" then "#A0A0A0"
    when "In process" then "#F278F2"
    when "In review" then "#F278F2"
    when "Beta" then "#2FC888"
    when "Launched" then "#2FC888"
    # when "Completed" then "#2FC888"
    # when "Archived" then "#ED9D02"
    end
  end

  # rubocop:enable Style/HashLikeCase
  def bg_stage_color
    case stage.capitalize
    when "Backlog" then "#EBEBEB"
    when "In process" then "#FAC7FA"
    when "In review" then "#FAC7FA"
    when "Beta" then "#ACECD1"
    when "Launched" then "#ACECD1"
    end
  end
  # rubocop:enable Style/HashLikeCase

  def self.filter_stages
    ["Backlog", "In process", "Launched"]
  end

  private

  def create_comment
    Comment.create(content: "The stage of this ticket has been updated to: #{stage}", user:, wish: self)
  end

  def asana_integration?
    wishlist.integrations.find_by(name: "Asana").present?
  end

  def send_to_asana
    asana = wishlist.asana_integration
    AsanaApi::SendTask.new(asana.api_token).call(asana.workspace, asana.project, title, description.to_plain_text)
  end

  def upvote
    Vote.create!(wish: self, user:)
  end
end

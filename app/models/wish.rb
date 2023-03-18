class Wish < ApplicationRecord
  belongs_to :wishlist
  validates :title, presence: true
  validates :description, presence: true
  has_many :votes, dependent: :destroy
  has_many :users
  belongs_to :user
  has_many :comments, dependent: :destroy
  enum stage: { "Backlog": 0, "In process": 1, "In review": 2, "Beta": 3, "Launched": 4 }
  # after_create_commit { broadcast_append_to "wishes" }

  # COLORS = ["ECEDFE", "EFFEEC", "FEFCEC", "FEECEC", "F9ECFE", "ECFEFE"]

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

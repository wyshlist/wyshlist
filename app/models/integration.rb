class Integration < ApplicationRecord
  belongs_to :wishlist
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :wishlist }
  validates :api_token, presence: true
  APPS = %w[Asana].freeze
  ACTIONS = ["Create a new task"].freeze
  # after_create :create_automation

  # def create_automation
  #   case name
  #   when "asana" && action == "Create a new task"
  #     AsanaApi::SendTask.new(self.api_token).call(self.)
  #   end
  # end
end
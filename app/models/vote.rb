class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :wish
  validates :user_id, uniqueness: { scope: :wish_id }
end

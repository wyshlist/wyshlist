class Vote < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :wish
  validates :user_id, uniqueness: { scope: :wish_id }
end

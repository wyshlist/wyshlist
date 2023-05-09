class Vote < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :wish, counter_cache: true
  validates :user_id, uniqueness: { scope: :wish_id }
end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :wish, counter_cache: true
  validates :content, presence: true, length: { minimum: 5, maximum: 500 }
end

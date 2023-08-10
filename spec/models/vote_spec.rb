require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      association = Vote.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a wish' do
      association = Vote.reflect_on_association(:wish)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'validates uniqueness of user_id scoped to wish_id' do
      user = FactoryBot.create(:user)
      wish = FactoryBot.create(:wish)
      FactoryBot.create(:vote, user:, wish:)

      duplicate_vote = FactoryBot.build(:vote, user:, wish:)
      expect(duplicate_vote).not_to be_valid
    end
  end
end

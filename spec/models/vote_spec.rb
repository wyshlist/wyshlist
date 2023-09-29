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
end

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it 'validates the presence of content' do
      let(:commment) { build(:comment) }
      expect(comment).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = Comment.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a wish' do
      association = Comment.reflect_on_association(:wish)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
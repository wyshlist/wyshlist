require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    let(:comment) { FactoryBot.create(:comment) }

    it 'validates the presence of content' do
      comment.content = nil

      expect(comment).not_to be_valid
    end

    it 'validates the content is at least 5 characters long' do
      comment.content = 'a' * 4

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

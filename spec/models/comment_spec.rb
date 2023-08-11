require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:wish) { FactoryBot.create(:wish) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      comment = Comment.new(user:, wish:, content: 'Test comment content')
      expect(comment).to be_valid
    end

    it 'is not valid without content' do
      comment = Comment.new(user:, wish:, content: nil)
      expect(comment).not_to be_valid
    end

    it 'is not valid with content less than 5 characters' do
      comment = Comment.new(user:, wish:, content: '1234')
      expect(comment).not_to be_valid
    end

    it 'is not valid with content more than 500 characters' do
      content = 501.times.map { 'a' }.join
      comment = Comment.new(user:, wish:, content:)

      expect(comment).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:wish) }
  end
end

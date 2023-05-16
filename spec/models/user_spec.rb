require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates the presence of an email' do
      user = User.new(email: '')
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many wishlists' do
      association = User.reflect_on_association(:wishlists)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many wishes' do
      association = User.reflect_on_association(:wishes)
      expect(association.macro).to eq(:has_many)
    end

    it 'belongs to an organization' do
      association = User.reflect_on_association(:organization)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
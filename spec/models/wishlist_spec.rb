# spec/models/wishlist_spec.rb

require 'rails_helper'

RSpec.describe Wishlist, type: :model do
  describe 'validations' do
    it 'validates the presence of a title' do
      wishlist = Wishlist.new(title: '')
      expect(wishlist).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = Wishlist.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many wishes' do
      association = Wishlist.reflect_on_association(:wishes)
      expect(association.macro).to eq(:has_many)
    end
  end
end
require 'rails_helper'

RSpec.describe Wish, type: :model do
  describe 'validations' do
    it 'validates the presence of a title' do
      wish = Wish.new(title: '')
      expect(wish).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = Wish.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a wishlist' do
      association = Wish.reflect_on_association(:wishlist)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      association = Wish.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many votes' do
      association = Wish.reflect_on_association(:votes)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'after update' do
    let(:owner) { User.create(email: "john@example.com", password: '123123') }
    let(:wishlist) { Wishlist.create(title: "New Wishlist", user_id: owner.id, description: "Lorem ipsum") }

    it 'create a new comment everytime there is an update' do
      wish = Wish.create(title: "New Wish", wishlist: wishlist, user: owner)
      expect { wish.update(stage: 'In review') }.to change { wish.comments.count }.by(1)
    end
  end
end

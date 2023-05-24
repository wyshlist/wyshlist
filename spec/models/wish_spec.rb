require 'rails_helper'

RSpec.describe Wish, type: :model do
  let(:user) { User.create(email: 'test@gmail.com', password: 'password', first_name: 'Test', last_name: 'User') }
  let(:wishlist) { Wishlist.create(title: 'Test Wishlist', user: user, description: "Test description", color: "ECEDFE") }
  let(:integration) { Integration.create(name: 'Asana', workspace: '523123124', project: '123123123', action: 'Create a new task', wishlist: wishlist, api_token: '123123123', user: user) }

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
end
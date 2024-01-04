require 'rails_helper'

RSpec.describe Wish, type: :model do
  let(:user) { User.create(email: 'test@gmail.com', password: 'password', first_name: 'Test', last_name: 'User') }
  let(:wishlist) do
    Wishlist.create(title: 'Test Wishlist', user:, description: "Test description", color: "ECEDFE")
  end
  let(:integration) do
    Integration.create(name: 'Asana', workspace: '523123124', project: '123123123', action: 'Create a new task',
                       wishlist:, api_token: '123123123', user:)
  end

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

  describe 'after commit' do
    let(:organization) { Organization.create(name: "New Organization") }
    let(:owner) { User.create(first_name: 'John', last_name: 'Doe', email: "john@example.com", organization_id: organization.id, password: '123123') }
    let(:wishlist) { Wishlist.create(title: "New Wishlist", user_id: owner.id, description: "Lorem ipsum") }

    it "automatically upvotes the wish by the owner" do
      wish = Wish.create(title: "New Wish", wishlist:, user: owner)
      expect(wish.votes.count).to eq(1)
      expect(wish.votes.first.user).to eq(owner)
    end
  end

  describe 'stages' do
    let(:organization) { Organization.create(name: "New Organization") }
    let(:owner) { User.create(first_name: 'John', last_name: 'Doe', email: "john@example.com", organization_id: organization.id, password: '123123') }
    let(:wishlist) { Wishlist.create(title: "New Wishlist", user_id: owner.id, description: "Lorem ipsum") }
    let(:wish) { Wish.create(title: "New Wish", wishlist:, user: owner) } 

    it "returns the correct color for each stage" do
      expect(wish.stage_color).to eq("#A0A0A0")
      wish.update(stage: "In process")
      expect(wish.stage_color).to eq("#F278F2")
      wish.update(stage: "Launched")
      expect(wish.stage_color).to eq("#2FC888")
    end
  end
end

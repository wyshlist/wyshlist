require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates the presence of an email' do
      user = User.new(email: '')
      expect(user).not_to be_valid
    end

    it 'validates the presence of a first name' do
      user = User.new(first_name: '')
      expect(user).not_to be_valid
    end

    it 'validates the presence of the last name' do
      user = User.new(last_name: '')
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

  describe 'methods' do
    it 'returns true if the user is an admin' do
      user = User.new(role: 'admin')
      expect(user.admin?).to eq(true)
    end
    
    it 'returns true if the user is a team member' do
      user = User.new(role: 'team_member')
      expect(user.team_member?).to eq(true)
    end

    it 'returns true if the user is a regular user' do
      user = User.new(role: 'user')
      expect(user.regular_user?).to eq(true)
    end

    it 'returns true if the user is a super team member' do
      user = User.new(role: 'super_team_member')
      expect(user.super_team_member?).to eq(true)
    end

    it 'returns true if the user is the owner of a record' do
      user = User.new
      record = double('record', user: user)
      expect(user.owner_of(record)).to eq(true)
    end

    it 'returns true if the user has an organization' do
      user = User.new(organization: Organization.new)
      expect(user.has_an_organization?).to eq(true)
    end

    it 'returns true if the user is a team member of an organization' do
      user = User.new(organization: Organization.new)
      expect(user.team_member_of(user.organization)).to eq(true)
    end

    it 'returns true if the user is the owner of a wishlist' do
      user = User.new
      wishlist = double('wishlist', user: user)
      expect(user.owner?(wishlist)).to eq(true)
    end

    it 'returns the full name of the user' do
      user = User.new(first_name: 'John', last_name: 'Doe')
      expect(user.full_name).to eq('John Doe')
    end

    it 'returns the initials of the user' do
      user = User.new(first_name: 'John', last_name: 'Doe')
      expect(user.initial).to eq('JD')
    end

    it 'returns true if the user is a member of an organization' do
      user = User.new(organization: Organization.new)
      expect(user.team_member_of(user.organization)).to eq(true)
    end

    it 'sends an email to the super team member when a new user is created' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john@gmail.com', password: '123123', role: 'super_team_member')
      expect { user.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends an email to the team member when a new user is created' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john@gmail.com', password: '123123', role: 'team_member')
      expect { user.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it ' does not send an email to the user when a new user is created' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'john@gmail.com', password: '123123', role: 'user')
      expect { user.save }.to change { ActionMailer::Base.deliveries.count }.by(0)
    end
  end


end

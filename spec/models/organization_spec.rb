# spec/models/organization_spec.rb
require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'associations' do
    it 'has many users' do
      association = Organization.reflect_on_association(:users)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      organization = Organization.new(name: 'Test Organization')
      expect(organization).to be_valid
    end

    it 'is not valid without a name' do
      organization = Organization.new(name: nil)
      expect(organization).to_not be_valid
    end
  end
end
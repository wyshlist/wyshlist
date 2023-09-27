# spec/models/organization_spec.rb
require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:organization) { FactoryBot.create(:organization) }
  describe 'associations' do
    it 'has many users' do
      association = Organization.reflect_on_association(:users)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'validates the presence of name' do
      organization.name = nil

      expect(organization).not_to be_valid
    end

    it 'validates the presence of subdomain' do
      organization.subdomain = nil

      expect(organization).not_to be_valid
    end
  end
end

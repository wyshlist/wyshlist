# spec/models/organization_spec.rb
require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'associations' do
    it 'has many users' do
      association = Organization.reflect_on_association(:users)
      expect(association.macro).to eq(:has_many)
    end
  end
end
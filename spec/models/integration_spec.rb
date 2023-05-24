require 'rails_helper'

RSpec.describe Integration, type: :model do

    describe 'associations' do
        it 'has many integrations' do
        association = Integration.reflect_on_association(:integrations)
        expect(association.macro).to eq(:has_many)
        end
    end
    
    describe 'validations' do
        it 'is valid with valid attributes' do
        integration = Integration.new(name: 'Test Integration')
        expect(integration).to be_valid
        end
    
        it 'is not valid without a name' do
        integration = Integration.new(name: nil)
        expect(integration).to_not be_valid
        end

        it 'is not valid without a url' do
            integration = Integration.new(url: nil)
            expect(integration).to_not be_valid
        end
    end
end

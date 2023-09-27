require 'rails_helper'

RSpec.describe Integration, type: :model do
  let(:user) { User.create(email: 'test@gmail.com', password: 'password', first_name: 'Test', last_name: 'User') }
  let(:wishlist) do
    Wishlist.create(title: 'Test Wishlist', user:, description: "Test description", color: "ECEDFE")
  end

  describe 'associations' do
    it 'belongs to a wishlist' do
      association = Integration.reflect_on_association(:wishlist)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      integration = Integration.create(name: 'Test Integration', workspace: '523123124', project: '123123123',
                                       action: 'Create a new task', wishlist:, api_token: '123123123', user:)
      expect(integration).to be_valid
    end

    it 'is not valid without a name' do
      integration = Integration.new(name: nil)
      expect(integration).to_not be_valid
    end

    it 'is not valid without a token' do
      integration = Integration.create(api_token: nil)
      expect(integration).to_not be_valid
    end

    it 'is not valid if name already exists for this wishlist' do
      integration = Integration.create(name: 'Asana', workspace: '523123124', project: '123123123',
                                       action: 'Create a new task', wishlist:, api_token: '123123123', user:)
      integration.save
      integration2 = Integration.create(name: 'Asana', workspace: '523123124', project: '123123123',
                                        action: 'Create a new task', wishlist:, api_token: '123123123', user:)
      expect(integration2).to_not be_valid
    end
  end
end

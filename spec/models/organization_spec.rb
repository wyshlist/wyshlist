require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_many(:users).dependent(:destroy) }
  it { should have_many(:wishlists).dependent(:destroy) }
  it { should have_many(:wishes).through(:wishlists) }
  it { should validate_presence_of(:name) }
  it { should have_one_attached(:logo) }

  describe 'validations' do
    it 'should validate the uniqueness of the name' do
      organization = FactoryBot.create(:organization)
      duplicate_organization = FactoryBot.build(:organization, name: organization.name)
      expect(duplicate_organization).to_not be_valid
    end
  end

  describe '#titleize_name' do
    it 'titleizes the name before saving' do
      organization = FactoryBot.build(:organization, name: 'test organization')
      organization.save
      expect(organization.name).to eq('Test Organization')
    end
  end

  describe '#organization_owner?' do
    let(:organization) { FactoryBot.build(:organization) }
    let(:owner) { FactoryBot.build(:user) }
    let(:member) { FactoryBot.build(:user) }

    before do
      organization.users << owner
      organization.users << member
    end

    it 'returns true if the user is the owner of the organization' do
      expect(organization.organization_owner?(owner)).to be_truthy
    end

    it 'returns false if the user is not the owner of the organization' do
      expect(organization.organization_owner?(member)).to be_falsy
    end
  end

  describe '#organization_member?' do
    let(:organization) { FactoryBot.build(:organization) }
    let(:owner) { FactoryBot.build(:user) }
    let(:member) { FactoryBot.build(:user) }

    before do
      organization.users << owner
      organization.users << member
    end

    it 'returns true if the user is a member of the organization' do
      expect(organization.organization_member?(member)).to be_truthy
    end

    it 'returns false if the user is not a member of the organization' do
      other_user = FactoryBot.create(:user)
      expect(organization.organization_member?(other_user)).to be_falsy
    end
  end

  describe '#subdomain' do
    it 'returns the subdomain based on the organization name' do
      organization = FactoryBot.create(:organization, name: 'Test Organization')
      expect(organization.subdomain).to eq('test_organization')
    end
  end
end

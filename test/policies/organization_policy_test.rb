require 'rails_helper'

class OrganizationPolicyTest < ActiveSupport::TestCase

  RSpec.describe OrganizationPolicy do
    subject { described_class.new(user, organization) }

    let(:organization) { FactoryBot.build_stubbed(:organization) }
    let(:user) { FactoryBot.build_stubbed(:record_owner_user) }
    let(:wishlist) { FactoryBot.build_stubbed(:wishlist) }
    let(:wish) { FactoryBot.build_stubbed(:wish) }
    let(:comment) { FactoryBot.build_stubbed(:comment) }

    context 'with visitors' do
      it { is_expected.to permit_actions(%i[new create show]) }
      it { is_expected.to forbid_actions(%i[edit update destroy feedback]) }
    end

    context 'with admins' do
      let(:user) { FactoryBot.build_stubbed(:admin) }

      it { is_expected.to permit_actions(%i[new create show edit update destroy feedback]) }
    end

    context 'with super team members' do
      let(:organization) { FactoryBot.build_stubbed(:organization) }
      let(:user) { FactoryBot.build_stubbed(:super_team_member, organization:) }

      it { is_expected.to permit_actions(%i[new create show edit update destroy feedback]) }
    end

    context 'with team members' do
      let(:organization) { FactoryBot.build_stubbed(:organization) }
      let(:user) { FactoryBot.build_stubbed(:team_member, organization:) }

      it { is_expected.to permit_actions(%i[new create show feedback]) }
      it { is_expected.to forbid_actions(%i[edit update destroy]) }
    end
  end
end

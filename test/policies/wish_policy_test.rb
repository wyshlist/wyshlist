require 'rails_helper'

class WishPolicyTest < ActiveSupport::TestCase
  RSpec.describe WishPolicy do
    subject { described_class.new(user, wish) }

    let(:wish) { FactoryBot.build_stubbed(:wish) }

    context 'with visitors' do
      let(:user) { FactoryBot.build_stubbed(:no_record_owner_user) }

      it { is_expected.to permit_actions(%i[new create show]) }
      it { is_expected.to forbid_actions(%i[edit update destroy]) }
    end

    context 'with wish owners' do
      let(:user) { FactoryBot.build_stubbed(:record_owner_user) }
      let(:wish) { FactoryBot.build_stubbed(:wish, user:) }

      it { is_expected.to permit_actions(%i[new create show edit update destroy]) }
    end

    context 'with admins' do
      let(:user) { FactoryBot.build_stubbed(:admin) }

      it { is_expected.to permit_actions(%i[new create show edit update destroy]) }
    end

    context 'with super team members' do
    let(:user) {FactoryBot.create(:super_team_member)}

    it { is_expected.to permit_actions(%i[new create show]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
    end

    context 'with team members' do
      let(:user) {FactoryBot.create(:team_member)}

      it { is_expected.to permit_actions(%i[new create show]) }
      it { is_expected.to forbid_actions(%i[edit update destroy]) }
    end
  end
end

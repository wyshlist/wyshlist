require 'rails_helper'

class VotePolicyTest < ActiveSupport::TestCase

  RSpec.describe VotePolicy do
    subject { described_class.new(user, vote) }

    let(:vote) { FactoryBot.build_stubbed(:vote) }

    context 'with visitors' do
      let(:user) { FactoryBot.build_stubbed(:no_record_owner_user) }

      it { is_expected.to permit_actions(%i[create]) }
      it { is_expected.to forbid_actions(%i[destroy]) }
    end

    context 'with vote owners' do
      let(:user) { FactoryBot.build_stubbed(:record_owner_user) }
      let(:vote) { FactoryBot.build_stubbed(:vote, user: user) }

      it { is_expected.to permit_actions(%i[destroy]) }
    end

    context 'with admins' do
      let(:user) { FactoryBot.build_stubbed(:admin) }

      it { is_expected.to permit_actions(%i[create destroy]) }
    end

    context 'with super team members' do
      let(:user) { FactoryBot.build_stubbed(:super_team_member) }

      it { is_expected.to permit_actions(%i[create]) }
      it { is_expected.to forbid_actions(%i[destroy]) }
    end

    context 'with team members' do
      let(:user) { FactoryBot.build_stubbed(:team_member) }

      it { is_expected.to permit_actions(%i[create]) }
      it { is_expected.to forbid_actions(%i[destroy]) }
    end
  end
end

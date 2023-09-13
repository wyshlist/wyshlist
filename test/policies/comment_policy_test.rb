require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { described_class.new(user, comment) }

  let(:organization) { FactoryBot.build_stubbed(:organization) }
  let(:user) { FactoryBot.build_stubbed(:record_owner_user) }
  let(:wishlist) { FactoryBot.build_stubbed(:wishlist) }
  let(:wish) { FactoryBot.build_stubbed(:wish) }
  let(:comment) { FactoryBot.build_stubbed(:comment) }

  context 'with visitors' do
    let(:user) {FactoryBot.build_stubbed(:no_record_owner_user)}

    it { is_expected.to permit_actions(%i[create]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
  end

  context 'with record owners' do
    let(:user) { FactoryBot.build_stubbed(:record_owner_user) }
    let(:comment) { FactoryBot.build_stubbed(:comment, user: user) }

    it { is_expected.to permit_actions(%i[create edit update destroy]) }
  end

  context 'with admins' do
    let(:user) { FactoryBot.build_stubbed(:admin) }

    it { is_expected.to permit_actions(%i[create edit update destroy]) }
  end

  context 'with super team members' do
    let(:user) { FactoryBot.build_stubbed(:super_team_member) }

    it { is_expected.to permit_actions(%i[create]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
  end

  context 'with team members' do
    let(:user) { FactoryBot.build_stubbed(:team_member) }

    it { is_expected.to permit_actions(%i[create]) }
    it { is_expected.to forbid_actions(%i[edit update destroy]) }
  end
end

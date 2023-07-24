require 'rails_helper'

class WishlistPolicyTest < ActiveSupport::TestCase
  RSpec.describe WishlistPolicy do
    subject { described_class.new(user, wishlist) }

    let(:wishlist) { FactoryBot.build_stubbed(:wishlist) }

    context 'with visitors' do
      let(:user) { FactoryBot.build_stubbed(:no_record_owner_user) }

      it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
    end

    context 'with wishlist owners' do
      let(:user) { FactoryBot.build_stubbed(:super_team_member) }
      let(:wishlist) { FactoryBot.build_stubbed(:wishlist, user:) }

      it { is_expected.to permit_actions(%i[new create edit update destroy]) }
    end

    context 'with admins' do
      let(:user) { FactoryBot.build_stubbed(:admin) }

      it { is_expected.to permit_actions(%i[new create edit update destroy]) }
    end

    context 'with super team members' do
      let(:user) { FactoryBot.build_stubbed(:super_team_member) }
      let(:wishlist) { FactoryBot.build_stubbed(:wishlist, user:) }

      it { is_expected.to permit_actions(%i[new create edit update destroy]) }
    end
  end
end

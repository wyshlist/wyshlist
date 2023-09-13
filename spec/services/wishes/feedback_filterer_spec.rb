require 'rails_helper'

RSpec.describe Wishes::FeedbackFilterer do
  let(:user) { FactoryBot.create(:record_owner_user) }

  describe '#call' do
    let!(:backlog_wish) { FactoryBot.create(:wish, stage: 'Backlog', user:) }
    let!(:in_process_wish) { FactoryBot.create(:wish, stage: 'In process', user:) }

    it 'filters by stage' do
      filter_params = { stage: 'In process' }

      filterer = described_class.new(filter_params:, scope: Wish.all)
      result = filterer.call

      expect(result).to all(have_attributes(stage: 'In process'))
    end

    it 'does not filter by stage if stage is blank' do
      filter_params = {}

      filterer = described_class.new(filter_params:, scope: Wish.all)
      result = filterer.call

      expect(result.pluck(:id)).to include(backlog_wish.id, in_process_wish.id)
    end

    it 'filters by wishlist' do
      wishlist = FactoryBot.create(:wishlist)
      wish = FactoryBot.create(:wish, wishlist:)

      filter_params = { wishlist_id: wishlist.id }

      filterer = described_class.new(filter_params:, scope: Wish.all)
      result = filterer.call

      expect(result.pluck(:id)).to include(wish.id)
    end
  end

  describe '#order' do
    let!(:wish_more_votes) { FactoryBot.create(:wish, user:, votes_count: 2) }
    let!(:wish_less_votes) { FactoryBot.create(:wish, user:, votes_count: 1) }

    it 'votes_count ASC' do
      filter_params = { order_column: 'votes_count', order_direction: 'ASC' }

      filterer = described_class.new(filter_params:, scope: Wish.all)
      result = filterer.call

      expect(result.last.id).to eq(wish_more_votes.id)
    end

    it 'votes_count DESC' do
      filter_params = { order_column: 'votes_count', order_direction: 'DESC' }

      filterer = described_class.new(filter_params:, scope: Wish.all)
      result = filterer.call

      expect(result.first.id).to eq(wish_more_votes.id)
    end

    it 'default -> votes_count DESC' do
      filter_params = {}

      filterer = described_class.new(filter_params:, scope: Wish.all)
      result = filterer.call

      expect(result.first.id).to eq(wish_more_votes.id)
    end
  end
end

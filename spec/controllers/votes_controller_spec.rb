require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:user) { create(:user) }
  let(:wish) { create(:wish) }

  describe 'POST #create' do
    before { sign_in user }

    context 'when vote is created successfully' do
      it 'redirects to wishlist wishes path' do
        post :create, params: { wish_id: wish.id }
        expect(response).to redirect_to(wishlist_wishes_path(wish.wishlist))
        expect(flash[:success]).to eq('You voted for this wish')
      end
    end

    context 'when vote cannot be created' do
      before { create(:vote, user:, wish:) }

      it 'redirects with a notice' do
        post :create, params: { wish_id: wish.id }
        expect(response).to redirect_to(wishlist_wishes_path(wish.wishlist))
        expect(flash[:notice]).to eq("You can't vote twice for the same wish")
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:vote) { create(:vote, user: user, wish: wish) }

    before { sign_in user }

    it 'destroys the vote and redirects' do
      delete :destroy, params: { id: vote.id }
      expect(response).to redirect_to(wishlist_wishes_path(wish.wishlist))
      expect(flash[:success]).to eq('You removed your vote')
      expect { vote.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

require 'rails_helper'

RSpec.describe WishesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:wishlist) { FactoryBot.create(:wishlist) }
  let(:wish) { FactoryBot.create(:wish, wishlist: wishlist) }

  describe 'GET #show' do
    before do
      sign_in user
      get :show, params: { id: wish.id }
    end

    it 'assigns the requested wish' do
      expect(assigns(:wish)).to eq(wish)
    end

    it 'assigns the wish list' do
      expect(assigns(:wishlist)).to eq(wish.wishlist)
    end

    it 'assigns comments' do
      expect(assigns(:comments)).to eq(wish.comments)
    end

    it 'assigns a new comment' do
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    before do
      sign_in user
      get :new, params: { wishlist_id: wishlist.id }
    end

    it 'assigns a new wish' do
      expect(assigns(:wish)).to be_a_new(Wish)
    end

    it 'assigns the wish list' do
      expect(assigns(:wishlist)).to eq(wishlist)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #index' do
    before do
      sign_in user
      get :index, params: { wishlist_id: wishlist.id }
    end

    it 'assigns the wish list' do
      expect(assigns(:wishlist)).to eq(wishlist)
    end

    it 'assigns stages' do
      expect(assigns(:stages)).to eq(Wish.distinct.pluck(:stage))
    end

    it 'assigns order column whitelist' do
      expect(assigns(:order_column_whitelist)).to eq(Wishes::Filterer::ORDER_COLUMN_WHITELIST.map { [_1.titleize, _1] })
    end

    it 'assigns order direction whitelist' do
      expect(assigns(:order_direction_whitelist)).to eq(Wishes::Filterer::ORDER_DIRECTION_WHITELIST.map { [_1.titleize, _1] })
    end
  end

  describe 'POST #create' do
    let(:wish_params) { FactoryBot.attributes_for(:wish) }

    before do
      sign_in user
    end

    it 'creates a new wish' do
      expect {
        post :create, params: { wishlist_id: wishlist.id, wish: wish_params }
      }.to change(Wish, :count).by(1)
    end

    it 'assigns the newly created wish' do
      post :create, params: { wishlist_id: wishlist.id, wish: wish_params }
      expect(assigns(:wish)).to be_a(Wish)
    end

    it 'redirects to the wishlist wishes path' do
      post :create, params: { wishlist_id: wishlist.id, wish: wish_params }
      expect(response).to redirect_to(wishlist_wishes_path(wishlist, anchor: "wish-#{Wish.last.id}"))
    end

    context 'with invalid params' do
      let(:invalid_wish_params) { FactoryBot.attributes_for(:wish, title: nil) }

      it 'does not create a new wish' do
        expect {
          post :create, params: { wishlist_id: wishlist.id, wish: invalid_wish_params }
        }.not_to change(Wish, :count)
      end

      it 're-renders the new template' do
        post :create, params: { wishlist_id: wishlist.id, wish: invalid_wish_params }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    before do
      sign_in user
      get :edit, params: { id: wish.id }
    end

    it 'assigns the requested wish' do
      expect(assigns(:wish)).to eq(wish)
    end
  end

  describe 'PATCH #update' do
    let(:valid_wish_params) { FactoryBot.attributes_for(:wish, title: 'Updated Title') }
    let(:record_owner) { FactoryBot.create(:record_owner_user) }
    let(:wish) { FactoryBot.create(:wish, wishlist:, user: record_owner) }

    before do
      sign_in record_owner
      patch :update, params: { id: wish.id, wish: valid_wish_params }
      wish.reload
    end

    it 'updates the wish' do
      expect(wish.title).to eq('Updated Title')
    end

    it 'redirects to the wish show page' do
      expect(response).to redirect_to(wish_path(wish))
    end

    context 'with invalid params' do
      let(:invalid_wish_params) { FactoryBot.attributes_for(:wish, title: nil) }

      before do
        patch :update, params: { id: wish.id, wish: invalid_wish_params }
        wish.reload
      end

      it 'does not update the wish' do
        expect(wish.title).not_to be_nil
      end

      it 're-renders the show template' do
        expect(response).to render_template('show')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:record_owner) { FactoryBot.create(:record_owner_user) }
    let(:wish) { FactoryBot.create(:wish, wishlist:, user: record_owner) }

    before do
      sign_in record_owner
    end

    it 'destroys the wish' do
      delete :destroy, params: { id: wish.id }
      expect(Wish.exists?(wish.id)).to be_falsey
    end

    it 'redirects to the wishlist wishes path' do
      delete :destroy, params: { id: wish.id }
      expect(response).to redirect_to(wishlist_wishes_path(wish.wishlist))
    end
  end
end

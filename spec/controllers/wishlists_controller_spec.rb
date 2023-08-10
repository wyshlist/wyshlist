# require 'rails_helper'

# RSpec.describe WishlistsController, type: :controller do
#   let(:organization) { FactoryBot.create(:organization) }
#   let(:user) { FactoryBot.create(:user, organization:) }
#   let(:wishlist) { FactoryBot.create(:wishlist, user:, organization:) }

#   before do
#     sign_in user
#   end

#   describe 'GET #index' do
#     it 'assigns the organization' do
#       get :index
#       expect(assigns(:organization)).to eq(organization)
#     end

#     it 'assigns wishlists sorted by wishes count' do
#       get :index
#       expect(assigns(:wishlists)).to eq(organization.wishlists.sort_by { |wishlist| -wishlist.wishes_count })
#     end
#   end

#   describe 'GET #new' do
#     it 'assigns the current user\'s organization' do
#       get :new
#       expect(assigns(:organization)).to eq(organization)
#     end

#     it 'assigns a new wishlist' do
#       get :new
#       expect(assigns(:wishlist)).to be_a_new(Wishlist)
#     end
#   end

#   describe 'POST #create' do
#     context 'with valid params' do
#       let(:wishlist_params) { FactoryBot.attributes_for(:wishlist) }

#       it 'creates a new wishlist' do
#         expect do
#           post :create, params: { wishlist: wishlist_params }
#         end.to change(Wishlist, :count).by(1)
#       end

#       it 'assigns the newly created wishlist' do
#         post :create, params: { wishlist: wishlist_params }
#         expect(assigns(:wishlist)).to be_a(Wishlist)
#       end

#       it 'redirects to the wishlist wishes path' do
#         post :create, params: { wishlist: wishlist_params }
#         expect(response).to redirect_to(wishlist_wishes_path(assigns(:wishlist)))
#       end
#     end

#     context 'with invalid params' do
#       let(:invalid_wishlist_params) { FactoryBot.attributes_for(:wishlist, title: nil) }

#       it 'does not create a new wishlist' do
#         expect do
#           post :create, params: { wishlist: invalid_wishlist_params }
#         end.not_to change(Wishlist, :count)
#       end

#       it 're-renders the new template' do
#         post :create, params: { wishlist: invalid_wishlist_params }
#         expect(response).to render_template(:new)
#       end
#     end
#   end

#   describe 'PATCH #update' do
#     context 'with valid params' do
#       let(:valid_wishlist_params) { FactoryBot.attributes_for(:wishlist, title: 'Updated Title') }

#       it 'updates the wishlist' do
#         patch :update, params: { id: wishlist.id, wishlist: valid_wishlist_params }
#         wishlist.reload
#         expect(flash[:notice]).to eq("Wishlist updated successfully")
#         expect(wishlist.title).to eq('Updated Title')
#       end

#       it 'redirects to the wishlist wishes path' do
#         patch :update, params: { id: wishlist.id, wishlist: valid_wishlist_params }
#         expect(response).to redirect_to(wishlist_wishes_path(wishlist))
#       end
#     end

#     context 'with invalid params' do
#       let(:invalid_wishlist_params) { FactoryBot.attributes_for(:wishlist, title: nil) }

#       it 'does not update the wishlist' do
#         original_title = wishlist.title
#         patch :update, params: { id: wishlist.id, wishlist: invalid_wishlist_params }
#         wishlist.reload
#         expect(flash[:alert]).to eq("There was a problem updating your wishlist, try again later")
#         expect(wishlist.title).to eq(original_title)
#       end

#       it 're-renders the edit template' do
#         patch :update, params: { id: wishlist.id, wishlist: invalid_wishlist_params }
#         expect(response).to render_template(:edit)
#       end
#     end
#   end

#   describe 'DELETE #destroy' do
#     it 'destroys the wishlist' do
#       wishlist
#       expect {
#         delete :destroy, params: { id: wishlist.id }
#       }.to change(Wishlist, :count).by(-1)
#     end

#     it 'sets a flash notice' do
#       delete :destroy, params: { id: wishlist.id }
#       expect(flash[:notice]).to eq('Board deleted successfully')
#     end

#     it 'redirects to wishlists_path' do
#       delete :destroy, params: { id: wishlist.id }
#       expect(response).to redirect_to(wishlists_path)
#     end
#   end
# end

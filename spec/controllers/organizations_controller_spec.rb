require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:organization) { FactoryBot.create(:organization) }
  let(:user) { FactoryBot.create(:user) }
  let(:super_team_member) { FactoryBot.create(:super_team_member, organization: organization) }

  describe 'GET #new' do
    before do
      sign_in user
      get :new
    end

    it 'assigns a new organization' do
      expect(assigns(:organization)).to be_a_new(Organization)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    before do
      sign_in user
      get :show, params: { id: organization.id }
    end

    it 'assigns the requested organization' do
      expect(assigns(:organization)).to eq(organization)
    end

    it 'assigns wishlists sorted by wishes count' do
      expect(assigns(:wishlists)).to eq(organization.wishlists.sort { |a, b| b.wishes.count <=> a.wishes.count })
    end

    it 'assigns the first wishlist' do
      expect(assigns(:wishlist)).to eq(organization.wishlists.first)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    before do
      sign_in user
    end

    context 'with valid params' do
      let(:organization_params) { FactoryBot.attributes_for(:organization) }

      it 'creates a new organization' do
        expect {
          post :create, params: { organization: organization_params }
        }.to change(Organization, :count).by(1)
      end

      it 'assigns the newly created organization' do
        post :create, params: { organization: organization_params }
        expect(assigns(:organization)).to be_a(Organization)
      end

      it 'redirects to the wishlists path' do
        post :create, params: { organization: organization_params }
        expect(response).to redirect_to(wishlists_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_organization_params) { FactoryBot.attributes_for(:organization, name: nil) }

      it 'does not create a new organization' do
        expect {
          post :create, params: { organization: invalid_organization_params }
        }.not_to change(Organization, :count)
      end

      it 're-renders the new template' do
        post :create, params: { organization: invalid_organization_params }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let(:organization) { FactoryBot.create(:organization) }

    before do
      sign_in super_team_member
    end

    context 'with valid params' do
      let(:valid_organization_params) { FactoryBot.attributes_for(:organization, name: 'Updated Name') }

      it 'updates the organization' do
        patch :update, params: { id: organization.id, organization: valid_organization_params }
        organization.reload
        expect(flash[:notice]).to eq("Organization updated successfully")
        expect(organization.name).to eq('Updated Name')
      end

      it 'redirects to the organization show page' do
        patch :update, params: { id: organization.id, organization: valid_organization_params }
        expect(response).to redirect_to(organization_path(organization))
      end
    end

    context 'with invalid params' do
      let(:invalid_organization_params) { FactoryBot.attributes_for(:organization, name: nil) }

      it 'does not update the organization' do
        original_name = organization.name
        patch :update, params: { id: organization.id, organization: invalid_organization_params }
        organization.reload
        expect(flash[:alert]).to eq("Organization not updated, try again later")
        expect(organization.name).to eq(original_name)
      end

      it 're-renders the edit template' do
        patch :update, params: { id: organization.id, organization: invalid_organization_params }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in super_team_member
    end

    context 'when user is authorized' do
      it 'destroys the organization' do
        expect {
          delete :destroy, params: { id: organization.id }
        }.to change(Organization, :count).by(-1)
      end

      it 'sets a flash notice' do
        delete :destroy, params: { id: organization.id }
        expect(flash[:notice]).to eq('Organization deleted successfully')
      end

      it 'redirects to root_path' do
        delete :destroy, params: { id: organization.id }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not authorized' do
      before do
        allow(controller).to receive(:authorize).and_raise(Pundit::NotAuthorizedError)
      end

      it 'does not destroy the organization' do
        expect {
          delete :destroy, params: { id: organization.id }
        }.not_to change(Organization, :count)
      end

      it 'redirects to root_path' do
        delete :destroy, params: { id: organization.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

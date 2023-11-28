require 'rails_helper'

RSpec.describe PassthroughController, type: :controller do
  describe "GET #index" do
    let(:team_member) { FactoryBot.create(:team_member) }
    let(:super_team_member) { FactoryBot.create(:super_team_member) }
    let(:admin) { FactoryBot.create(:admin) }
    let(:user) { FactoryBot.create(:no_record_owner_user) }

    context "when user is a team member" do
      before do
        sign_in team_member
      end

      it "redirects to the feedback page" do
        get :index
        expect(response).to redirect_to(feedback_url(subdomain: team_member.organization.subdomain))
      end
    end

    context "when user is a super team member" do
      before do
        sign_in super_team_member
      end

      it "redirects to the feedback page" do
        get :index
        expect(response).to redirect_to(feedback_url(subdomain: super_team_member.organization.subdomain))
      end
    end

    context "when user is an admin" do
      before do
        sign_in admin
      end

      it "redirects to the rails admin page" do
        get :index
        expect(response).to redirect_to(rails_admin_path)
      end
    end

    context "when user is a user" do
      before do
        sign_in user
      end

      it "redirects to the get started page" do
        get :index
        expect(response).to redirect_to(wishlists_path)
      end
    end
  end
end

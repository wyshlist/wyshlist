require 'rails_helper'

RSpec.describe PassthroughController, type: :controller do
  describe "GET #index" do
    let(:team_member) { create(:team_member) }
    let(:super_team_member) { create(:super_team_member) }
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }

    context "when user is a team member" do
      before do
        sign_in team_member
      end

      it "redirects to the feedback page" do
        get :index
        expect(response).to redirect_to(feedback_path)
      end
    end

    context "when user is a super team member" do
      before do
        sign_in super_team_member
      end

      it "redirects to the feedback page" do
        get :index
        expect(response).to redirect_to(feedback_path)
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
        expect(response).to redirect_to(get_started_path)
      end
    end
  end
end

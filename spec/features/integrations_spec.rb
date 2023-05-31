require 'rails_helper'

RSpec.feature 'integrations', type: :feature do
    let(:user) { User.create(email: 'test@gmail.com', password: 'password') }
    let(:other_user) { User.create(email: 'other_user@gmail.com', password: 'password') }   
    let(:wishlist) { Wishlist.create(title: 'Test Wishlist', user: user, description: "Test description", color: "ECEDFE") }

    before do
        sign_in user
    end

    scenario 'User can only create an integration if owner of the integration' do
        sign_in other_user
        visit new_wishlist_integration_path(wishlist)
        expect(page).to have_content("You are not authorized to perform this action.")
    end

    scenario 'User cannot create an integration if it alreasy exists' do
        integration = Integration.create(name: 'Asana' , workspace: '523123124', project: '123123123', action: 'Create a new task', wishlist: wishlist, api_token: '123123123', user: user)
        visit wishlist_wishes_path(wishlist)

        expect(page).to_not have_content("Connect to")
    end

    scenario 'User can create an integration if it does not exist yet' do
        visit wishlist_wishes_path(wishlist)
        expect(page).to have_content("Connect to")
    end
end

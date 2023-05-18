# spec/features/wishlists_spec.rb
require 'rails_helper'

RSpec.feature 'Wishlists', type: :feature do
    let(:user) { User.create(email: 'test@example.com', password: 'password') }
    let(:other_user) { User.create(email: 'other@example.com', password: 'password') }
    let(:wish) { Wish.create(title: 'Test Wish', user: user) }
    let(:other_wish) { Wish.create(title: 'Other Wish', user: other_user) }
    let(:organization) { Organization.create(name: 'Test Organization') }
    let(:wishlist) { Wishlist.create(title: 'Test Wishlist', user: user, description: "Test description", color: "ECEDFE", organization: organization) }
    let(:other_wishlist) { Wishlist.create(title: 'Other Wishlist', user: other_user, description: "Test description", color: "ECEDFE", organization: organization) }

    before do
        sign_in user
    end

    scenario 'User creates a public wishlist' do
        visit new_wishlist_path

        fill_in 'Title', with: 'Test Wishlist'
        fill_in 'Description', with: 'A wishlist'
        find('label', text: 'ECEDFE').click


        click_button 'Submit'

        expect(Wishlist.last).to have_attributes(
        title: 'Test Wishlist',
        description: 'A wishlist',
        color: 'ECEDFE',
        user: user
        )
    end

    scenario 'User creates a public wishlist with a color' do
        visit new_wishlist_path

        fill_in 'Title', with: 'Test Wishlist'
        fill_in 'Description', with: 'A wishlist'
        find('label', text: 'ECEDFE').click
        # check 'Color', with: '#ECEDFE'

        click_button 'Submit'

        expect(Wishlist.last).to have_attributes(
            title: 'Test Wishlist',
            description: 'A wishlist',
            color: 'ECEDFE',
            user: user
        )
    end

    scenario 'User creates a public wishlist without a color' do
        visit new_wishlist_path

        fill_in 'Title', with: 'Test Wishlist'
        fill_in 'Description', with: 'A wishlist'
        
        click_button 'Submit'

        expect(page).to have_content("Color can't be blank")
    end

    scenario 'User creates a private wishlist' do
        visit new_wishlist_path

        fill_in 'Title', with: 'Test Wishlist'
        fill_in 'Description', with: 'A wishlist'
        find('label', text: 'ECEDFE').click
        check 'private'

        click_button 'Submit'

        expect(Wishlist.last).to have_attributes(
        title: 'Test Wishlist',
        description: 'A wishlist',
        color: 'ECEDFE',
        user: user,
        private: true
        )
    end

    scenario 'User edits a wishlist' do

        visit edit_wishlist_path(wishlist)

        fill_in 'Title', with: 'Test Wishlist 2'
        fill_in 'Description', with: 'A wishlist 2'
        find('label', text: 'ECEDFE').click
        click_button 'Submit'

        expect(wishlist.reload).to have_attributes(
        title: 'Test Wishlist 2',
        description: 'A wishlist 2',
        color: 'ECEDFE',
        user: user
        )
    end

    scenario 'User deletes a wishlist' do

        visit wishlist_wishes_path(wishlist)

        first('#delete-wishlist').click

        expect(Wishlist.find_by(id: wishlist.id)).to be_nil
    end

    scenario 'User views a wishlist' do
        wishlist = Wishlist.create(title: 'Test Wishlist', user: user, description: 'A wishlist')
        visit wishlist_wishes_path(wishlist)

        expect(page).to have_text('Test Wishlist')
    end

    scenario 'User not teammate views a private wishlist' do
        other_wishlist = Wishlist.create(title: 'Other User Wishlist', user: other_user, description: 'A wishlist', private: true)

        visit wishlist_wishes_path(other_wishlist)

        expect(page).to have_text('You are not authorized to perform this action.')
    end

    scenario 'User teammate views a private wishlist' do
        organization = Organization.create(name: 'Test Organization')
        user.update(organization: organization)
        other_user.update(organization: organization)
        other_wishlist = Wishlist.create(title: 'Other User Wishlist', user: other_user, description: 'A wishlist', private: true)
        
        visit wishlist_wishes_path(other_wishlist)

        expect(page).to have_text('Other User Wishlist')
    end

    scenario 'User views a wishlist in the feed' do
        wishlist = Wishlist.create(title: 'Test Wishlist', user: user, description: 'A wishlist')

        visit wishlists_path

        expect(page).to have_text('Test Wishlist')
    end

    scenario 'User views a private wishlist in the feed' do
        wishlist = Wishlist.create(title: 'Other User Wishlist', user: other_user, description: 'A wishlist', private: true)

        visit wishlists_path

        expect(page).not_to have_text('Other User Wishlist')
    end

    scenario 'User views a wishlist in the feed after voting for a wish' do
        wish = Wish.create(title: 'Test Wish', wishlist: other_wishlist, user: other_user)

        visit wishlist_wishes_path(other_wishlist)

        first('#upvote').click

        visit wishlists_path

        expect(page).to have_text('Other Wishlist')
    end

    scenario 'User dont view a wishlist in the feed after unvoting for a wish' do
        wish = Wish.create(title: 'Test Wish', wishlist: other_wishlist, user: other_user)
        Vote.create(user: user, wish: wish)

        visit wishlist_wishes_path(other_wishlist)

        first('#downvote').click

        visit wishlists_path

        expect(page).to_not have_text('Other Wishlist')
    end

    scenario "Feed's wishlists are sorted by number of votes" do
        # Create a wishlist with 3 wishes
        wishlist = Wishlist.create(title: 'Test Wishlist', user: user, description: 'A wishlist', color: "ECEDFE")
        wish = Wish.create(title: 'Test Wish', wishlist: other_wishlist, user: other_user)
        wish2 = Wish.create(title: 'Test Wish 2', wishlist: other_wishlist, user: other_user)
        wish3 = Wish.create(title: 'Test Wish 3', wishlist: other_wishlist, user: other_user)
        Vote.create(user: user, wish: wish)
        Vote.create(user: user, wish: wish)
        Vote.create(user: user, wish: wish3)
      
        visit wishlists_path
      
        # Assuming the wishlist titles are displayed in a certain order, you can check the order of the titles
        wishlist_titles = page.all('.wishlist-title').map(&:text)
      
        # Make sure the wishlists are sorted by number of votes in descending order
        expect(wishlist_titles).to eq(['Other Wishlist', 'Test Wishlist'])
      
        # Additional assertions or expectations if needed
    end

    scenario "organization's wishlists are sorted by number of votes" do
        # Create a wishlist with 3 wishes
        wishlist = Wishlist.create(title: 'Test Wishlist', user: user, description: 'A wishlist', color: "ECEDFE", organization: organization)
        wish = Wish.create(title: 'Test Wish', wishlist: other_wishlist, user: other_user)
        wish2 = Wish.create(title: 'Test Wish 2', wishlist: other_wishlist, user: other_user)
        wish3 = Wish.create(title: 'Test Wish 3', wishlist: other_wishlist, user: other_user)
        Vote.create(user: user, wish: wish)
        Vote.create(user: user, wish: wish)
        Vote.create(user: user, wish: wish3)
      
        visit organization_path(organization)
      
        # Assuming the wishlist titles are displayed in a certain order, you can check the order of the titles
        wishlist_titles = page.all('.wishlist-title').map(&:text)
      
        # Make sure the wishlists are sorted by number of votes in descending order
        expect(wishlist_titles).to eq(['Other Wishlist', 'Test Wishlist'])
      
        # Additional assertions or expectations if needed
    end
end 


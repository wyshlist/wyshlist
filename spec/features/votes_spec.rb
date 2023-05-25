require 'rails_helper'

RSpec.feature 'votes', type: :feature do
    let(:user) { User.create(email: 'test@example.com', password: 'password') }
    let(:other_user) { User.create(email: 'other@example.com', password: 'password') }
    let(:wishlist) { Wishlist.create(title: 'Test Wishlist', user: user, description: "Test description") }
    let(:other_wishlist) { Wishlist.create(title: 'Other Wishlist', user: other_user, description: "Test description") }
    let(:wish) { Wish.create(title: 'Test Wish', user: user, wishlist: wishlist ) }
    let(:other_wish) { Wish.create(title: 'Other Wish', user: other_user, wishlist: other_wishlist ) }

    before do
        sign_in user
    end

    scenario 'User can vote for a wish' do
        wish = Wish.create(title: 'Test Wish', wishlist: other_wishlist, user: other_user)
        visit wishlist_wishes_path(other_wishlist)
        first('#upvote').click
        expect(Vote.last).to eq(Vote.find_by(user: user, wish: wish))
    end

    scenario 'User can unvote for a wish' do
        wish = Wish.create(title: 'Test Wish', wishlist: other_wishlist, user: other_user)
        Vote.create(user: user, wish: wish)
        visit wishlist_wishes_path(other_wishlist)
        first('#downvote').click
        expect(Vote.find_by(user: user, wish: wish)).to be_nil
    end

    # scenario 'User can vote for a wish if not signed in on public wishlist' do
    #     sign_out user
    #     visit wishlist_wishes_path(other_wishlist)
    #     first('#upvote').click
    #     expect(Vote.last).to eq(Vote.find_by(user: nil, wish: other_wish))
    # end
end

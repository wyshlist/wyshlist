require 'rails_helper'

RSpec.feature 'Wishes', type: :feature do
    let(:user) { User.create(email: 'test@example.com', password: 'password') }
    let(:other_user) { User.create(email: 'other@example.com', password: 'password') }
    let(:wishlist) { Wishlist.create(title: 'Test Wishlist', user: user, description: "Test description") }
    let(:other_wishlist) { Wishlist.create(title: 'Other Wishlist', user: other_user, description: "Test description") }
    let(:wish) { Wish.create(title: 'Test Wish', user: user, wishlist: wishlist ) }
    let(:other_wish) { Wish.create(title: 'Other Wish', user: other_user, wishlist: other_wishlist ) }

    before do
        sign_in user
    end

end

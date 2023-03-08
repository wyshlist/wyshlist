class WishlistsController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :index ]
    def index
        @wishlists = Wishlist.all
    end
end

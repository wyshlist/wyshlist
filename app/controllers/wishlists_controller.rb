class WishlistsController < ApplicationController
    def index
        @organization = current_user.organization
        @wishlists = current_user.has_an_organization? ? @organization.wishlists : current_user.wishlists
    end

    def show
        @wishlist = Wishlist.find(params[:id])
        @wishes = @wishlist.wishes
        @vote = Vote.new
        @wish = Wish.new
    end
end

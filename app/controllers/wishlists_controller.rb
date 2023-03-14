class WishlistsController < ApplicationController
    add_breadcrumb "home", :root_path

    def index
        @organization = current_user.organization
        @wishlists = current_user.has_an_organization? ? @organization.wishlists : current_user.wishlists
        add_breadcrumb "whislists", wishlists_path
    end

    def show
        @wishlist = Wishlist.find(params[:id])
        @wishes = @wishlist.wishes
        @vote = Vote.new
        @wish = Wish.new
        add_breadcrumb "#{@wishlist.title}", wishlist_path(@wishlist)
    end

    def new
        @wishlist = Wishlist.new
    end

    def create
        @wishlist = Wishlist.new(wishlist_params)
        @wishlist.user = current_user
        if @wishlist.save
            flash[:notice] = "Wishlist created successfully"
            redirect_to wishlist_path(@wishlist)
        else
            render :new
        end
    end

    private

    def wishlist_params
        params.require(:wishlist).permit(:title, :description, :color)
    end
end

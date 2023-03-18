class WishlistsController < ApplicationController
    add_breadcrumb "home", :root_path

    def index
        @organization = current_user.organization
        @wishlists = current_user.has_an_organization? ? @organization.wishlists : current_user.wishlists
        add_breadcrumb "whislists", wishlists_path
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

    def destroy
        @wishlist = Wishlist.find(params[:id])
        if @wishlist.destroy
            flash[:notice] = "Wishlist deleted successfully"
            redirect_to wishlists_path
        else
            flash[:alert] = "Wishlist not deleted, try again later"
            redirect_to wishlist_path(@wishlist)
        end
    end

    private

    def wishlist_params
        params.require(:wishlist).permit(:title, :description, :color)
    end
end

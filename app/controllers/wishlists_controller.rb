class WishlistsController < ApplicationController
    add_breadcrumb "home", :root_path

    def index
        @organization = current_user.organization
        @wishlists =  current_user ? current_user.all_wishlists : []
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
            redirect_to wishlist_wishes_path(@wishlist)
        else
            flash[:alert] = "There was a problem creating your wishlist, try again later"
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
            redirect_to wishlist_wishes_path(@wishlist)
        end
    end

    def edit
        @wishlist = Wishlist.find(params[:id])
    end

    def update
        @wishlist = Wishlist.find(params[:id])
        if @wishlist.update(wishlist_params)
            flash[:notice] = "Wishlist updated successfully"
            redirect_to wishlist_wishes_path(@wishlist)
        else
            flash[:alert] = "There was a problem updating your wishlist, try again later"
            render :edit
        end
    end

    private

    def wishlist_params
        params.require(:wishlist).permit(:title, :description, :color, :private)
    end
end

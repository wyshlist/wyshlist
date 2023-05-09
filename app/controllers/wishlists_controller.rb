class WishlistsController < ApplicationController
    add_breadcrumb "home", :root_path

    def index
        @organization = current_user.organization
        @wishlists =  policy_scope(Wishlist).sorted_by_votes
        add_breadcrumb "Wishlists", wishlists_path
    end

    def new
        @wishlist = Wishlist.new
        authorize @wishlist
    end

    def create
        @wishlist = Wishlist.new(wishlist_params)
        @wishlist.user = current_user
        authorize @wishlist
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
        authorize @wishlist
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
        authorize @wishlist
    end

    def update
        @wishlist = Wishlist.find(params[:id])
        authorize @wishlist
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

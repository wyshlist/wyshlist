class WishlistsController < ApplicationController
    add_breadcrumb "home", :root_path

    def index
        @organization = current_user.organization
        @wishlists = policy_scope(Wishlist)
        .joins("LEFT JOIN wishes ON wishes.wishlist_id = wishlists.id")
        .joins("LEFT JOIN votes ON votes.wish_id = wishes.id")
        .joins("LEFT JOIN comments ON comments.wish_id = wishes.id")
        .where("wishlists.user_id = ? OR wishes.user_id = ? OR comments.user_id = ? OR votes.user_id = ?", current_user.id, current_user.id, current_user.id, current_user.id)
        .select("wishlists.*, COUNT(DISTINCT wishes.id) AS wishes_count")
        .group("wishlists.id")
        .distinct
        .order("wishes_count DESC")
    end

    def new
        @organization = Organization.find(params[:organization]) if params[:organization]
        @wishlist = Wishlist.new
        authorize @wishlist
    end

    def create
        @wishlist = Wishlist.new(wishlist_params)
        @wishlist.user = current_user
        authorize @wishlist
        if @wishlist.save
            flash[:notice] = "Board created successfully"
            redirect_to wishlist_wishes_path(@wishlist)
        else
            flash[:alert] = "There was a problem creating your board, try again later"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @wishlist = Wishlist.find(params[:id])
        authorize @wishlist
        if @wishlist.destroy
            flash[:notice] = "Board deleted successfully"
            redirect_to wishlists_path
        else
            flash[:alert] = "Board not deleted, try again later"
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

class WishesController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :index, :show ]

    def show
        @wish = Wish.find(params[:id])
        @wishlist = @wish.wishlist
        @comments = @wish.comments
        @comment = Comment.new
    end

    def new
        @wish = Wish.new
        @wishlist = Wishlist.find(params[:wishlist_id])
    end

    def create
        @wish = Wish.new(wish_params)
        @wish.user = current_user
        @wish.wishlist = Wishlist.find(params[:wishlist_id])
        if @wish.save
            redirect_to wishlist_path(@wish.wishlist)
        else
            render 'wishlists/show', status: :unprocessable_entity
        end
    end


    private

    def wish_params
        params.require(:wish).permit(:title, :description)
    end
end

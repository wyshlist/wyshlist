class WishesController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :show, :index ] if :verify_private_wishlist

    def show
        @wish = Wish.find(params[:id])
        @wishlist = @wish.wishlist
        @comments = @wish.comments
        @comment = Comment.new
        add_breadcrumb "< Back to Wishlist", wishlist_wishes_path(@wishlist)
    end

    def new
        @wish = Wish.new
        @wishlist = Wishlist.find(params[:wishlist_id])
    end

    def index
        @wishlist = Wishlist.find(params[:wishlist_id])
        if params[:stage]
            @wishes = @wishlist.wishes.where(stage: params[:stage])
        else
            @wishes = @wishlist.wishes
        end
        @vote = Vote.new
        add_breadcrumb "< Back to Wishlists", wishlists_path
    end

    def create
        @wish = Wish.new(wish_params)
        @wish.user = current_user
        @wish.wishlist = Wishlist.find(params[:wishlist_id])
        if @wish.save
            flash[:notice] = "Wish created successfully"
            redirect_to wishlist_wishes_path(@wish.wishlist, anchor: "wish-#{@wish.id}")
        else
            flash[:alert] = "Wish not created, try again later"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @wish = Wish.find(params[:id])
    end

    def verify_private_wishlist
        @wishlist = Wishlist.find(params[:wishlist_id])
        @wishlist.private == false
    end

    private


    def wish_params
        params.require(:wish).permit(:title, :description)
    end
end

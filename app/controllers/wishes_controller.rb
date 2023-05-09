class WishesController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :show, :index ] if :verify_private_wishlist

    def show
        @wish = Wish.find(params[:id])
        @wishlist = @wish.wishlist
        @comments = @wish.comments
        @comment = Comment.new
        authorize @wish
        add_breadcrumb "Wishes", wishlist_wishes_path(@wishlist)
    end

    def new
        @wish = Wish.new
        @wishlist = Wishlist.find(params[:wishlist_id])
        authorize @wish
    end

    def index
        @wishlist = Wishlist.find(params[:wishlist_id])
        @wishes = policy_scope(@wishlist.wishes).sorted_by_votes
        if params[:stage]
          @wishes = @wishes.where(stage_params)
        end
        @vote = Vote.new
        add_breadcrumb "< Wishlists", wishlists_path
    end

    def create
        @wish = Wish.new(wish_params)
        @wish.user = current_user
        @wish.wishlist = Wishlist.find(params[:wishlist_id])
        @wishlist = @wish.wishlist
        authorize @wish
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
        authorize @wish
    end

    def update
        @wish = Wish.find(params[:id])
        authorize @wish
        if @wish.update(wish_params)
            flash[:notice] = "Wish updated successfully, only you as wishlist owner can update the stage of a wish"
            redirect_to wish_path(@wish)
        else
            flash[:alert] = "Wish not updated, try again later"
            render "show", status: :unprocessable_entity
        end
    end

    def verify_private_wishlist
        @wishlist = Wishlist.find(params[:wishlist_id])
        @wishlist.private == false
    end

    private

    def stage_params
        params.permit(:stage)
    end


    def wish_params
        params.require(:wish).permit(:title, :description, :stage)
    end
end

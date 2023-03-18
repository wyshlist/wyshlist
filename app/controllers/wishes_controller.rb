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

    def index
        @wishlist = Wishlist.find(params[:wishlist_id])
        @wishes = @wishlist.wishes
        @vote = Vote.new
        add_breadcrumb "#{@wishlist.title}", wishlist_path(@wishlist)
    end

    def create
        @wish = Wish.new(wish_params)
        @wish.user = current_user
        @wish.wishlist = Wishlist.find(params[:wishlist_id])
        if @wish.save
            flash[:notice] = "Wish created successfully"
            redirect_to wishlist_wishes_path(@wish.wishlist)
        else
            flash[:alert] = "Wish not created, try again later"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @wish = Wish.find(params[:id])
    end


    private

    def wish_params
        params.require(:wish).permit(:title, :description)
    end
end

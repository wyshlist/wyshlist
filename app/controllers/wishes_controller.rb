class WishesController < ApplicationController
    skip_before_action :authenticate_user!, only: [ :show, :index ] if :verify_private_wishlist
    after_action :verify_authorized

    def show
        @wish = Wish.find(params[:id])
        @wishlist = @wish.wishlist
        @comments = @wish.comments
        @comment = Comment.new
        authorize @wish
        add_breadcrumb "Tickets", wishlist_wishes_path(@wishlist)
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
        elsif params[:query].present?
            @wishes = Wish.search_by_title_and_description(params[:query])

        end
        authorize @wishlist
        @vote = Vote.new
        add_breadcrumb "< Boards", wishlists_path
    end

    def create
        @wish = Wish.new(wish_params)
        @wish.user = current_user
        @wish.wishlist = Wishlist.find(params[:wishlist_id])
        @wishlist = @wish.wishlist
        authorize @wish
        if @wish.save
            flash[:notice] = "Ticket created successfully"
            redirect_to wishlist_wishes_path(@wish.wishlist, anchor: "wish-#{@wish.id}")
        else
            flash[:alert] = "Ticket not created, try again later"
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
            flash[:notice] = "Ticket updated successfully, only you as a board owner can update the stage of a wish"
            redirect_to wish_path(@wish)
        else
            flash[:alert] = "Ticket not updated, try again later"
            render "show", status: :unprocessable_entity
        end
    end

    def destroy
        @wish = Wish.find(params[:id])
        authorize @wish
        if @wish.destroy
            flash[:notice] = "Ticket deleted successfully"
            redirect_to wishlist_wishes_path(@wish.wishlist)
        else
            flash[:alert] = "Ticket not deleted, try again later"
            redirect_to wish_path(@wish)
        end
    end

    def verify_private_wishlist
        @wishlist = Wishlist.find(params[:wishlist_id])
        @wishlist.private == false
    end

    private

    def stage_params
        params.permit(stage: [])
    end


    def wish_params
        params.require(:wish).permit(:title, :description, :stage)
    end
end

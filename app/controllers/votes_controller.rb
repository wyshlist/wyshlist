class VotesController < ApplicationController
    def create
        @vote = Vote.new
        @vote.user = current_user
        @vote.wish = Wish.find(params[:wish_id])
        if @vote.save
            flash[:success] = "You voted for this wish"
            redirect_to wishlist_wishes_path(@vote.wish.wishlist)
        else
            flash[:notice] = "You can't vote twice for the same wish"
            redirect_to wishlist_wishes_path(@vote.wish.wishlist), status: :unprocessable_entity
        end
    end
    
    def destroy
        @vote = Vote.find(params[:id])
        @vote.destroy
        flash[:success] = "You removed your vote"
        redirect_to wishlist_wishes_path(@vote.wish.wishlist)
    end
end

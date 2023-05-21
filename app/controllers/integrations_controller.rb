class IntegrationsController < ApplicationController

    def new
        @wishlist = Wishlist.find(params[:wishlist_id])
        @integration = Integration.new
        authorize @integration
    end

    def create
        @wishlist = Wishlist.find(params[:wishlist_id])
        @integration = Integration.new(integration_params)
        @integration.wishlist = @wishlist
        @integration.user = current_user
        authorize @integration
        if @integration.save
            redirect_to wishlist_path(@wishlist)
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @integration = Integration.find(params[:id])
        @integration.destroy
        redirect_to wishlist_wishes_path(@integration.wishlist)
    end
end

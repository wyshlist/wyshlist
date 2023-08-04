class OrganizationsController < ApplicationController
    before_action :set_organization, only: [:show, :edit, :update, :destroy]
    before_action :order_column_whitelist,
                  :order_direction_whitelist,
                  :set_stages,
                  :set_wishlists, only: :feedback
    def new
        @organization = Organization.new
        authorize @organization
        @organization_search = ""
    end

    def show
        @wishlists = @organization.wishlists.sort { |a,b| b.wishes.count <=> a.wishes.count }
        @wishlist = @organization.wishlists.first
        authorize @organization
    end

    def create
        if params[:organization_search] && params[:organization_search] != ""
            handle_existing_organization(params[:organization_search])
        else
            @organization = Organization.create(organization_params)
            authorize @organization
            if @organization.save
                update_user_and_redirect(@organization)
            else
                render :new, status: :unprocessable_entity
            end
        end
    end

    def edit
        authorize @organization
    end

    def update
        authorize @organization
        if @organization.update(organization_params)
            flash[:notice] = "Organization updated successfully"
            redirect_to organization_path(@organization)
        else
            flash[:alert] = "Organization not updated, try again later"
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        authorize @organization
        @organization.destroy
        flash[:notice] = "Organization deleted successfully"
        redirect_to root_path
    end

    def feedback
      organization = current_user.organization
      authorize organization
      @wishes = organization.wishes
      if params[:filter].present?
        @wishes = Wishes::FeedbackFilterer.new(filter_params:, scope: @wishes).call
      end
    end

    private

    def order_column_whitelist
      @order_column_whitelist ||=
        Wishes::FeedbackFilterer::ORDER_COLUMN_WHITELIST.map { [_1.titleize, _1] }
    end

    def order_direction_whitelist
      @order_direction_whitelist ||=
        Wishes::FeedbackFilterer::ORDER_DIRECTION_WHITELIST.map { [_1.titleize, _1] }
    end

    def set_stages
      @stages = Wish.distinct.pluck(:stage)
    end

    def set_wishlists
      @wishlists = current_user.organization.wishlists
    end

    def filter_params
      params[:filter].permit(:stage, :wishlist_id, :order_column, :order_direction)
    end

    def set_organization
      @organization = Organization.find(params[:id])
      authorize @organization
    end

    def organization_params
        params.require(:organization).permit(:name, :logo, :color)
    end

    def handle_existing_organization(organization_name)
        @organization = Organization.where('LOWER(name) ILIKE ?', organization_name.downcase).first || @organization = Organization.new
        if @organization.id
            update_user_and_redirect(@organization)
            authorize @organization
        else
            redirect_to new_organization_path, alert: "Team not found, maybe you should create it?"
            authorize @organization
        end
    end

    def update_user_and_redirect(organization)
        current_user.update(organization: organization)
        redirect_to wishlists_path, alert: "Team #{organization.name} added successfully"
    end
end

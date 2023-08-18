class OrganizationsController < ApplicationController
    before_action :set_organization, only: [:show, :edit, :update, :destroy]
    before_action :check_team_member_subdomain, only: [:feedback, :edit, :update]

    def new
        @organization = Organization.new
        @organization_search = ""
        authorize @organization
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
            redirect_to organization_path(subdomain: @organization.subdomain)
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
    end

    private

    def set_organization
      @organization = Organization.find(params[:id]) if params[:id]
      @organization = Organization.find_by(subdomain: request.subdomain)
      authorize @organization
    end

    def organization_params
        params.require(:organization).permit(:name, :logo, :color, :subdomain)
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
        current_user.update(organization: organization, role: 'super_team_member', super_team_member_since: Time.now)
        redirect_to root_path, alert: "Team #{organization.name} added successfully"
    end
end

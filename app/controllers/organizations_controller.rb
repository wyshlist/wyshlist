class OrganizationsController < ApplicationController
    before_action :set_organization, only: [:show, :edit, :update, :destroy]
    before_action :check_subdomain, only: [:feedback]

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
    end

    private

    def check_subdomain
      if current_user.organization.nil?
        redirect_to new_organization_path
      elsif request.subdomain != current_user.organization.subdomain
        redirect_to authenticated_root_url(subdomain: current_user.organization.subdomain), allow_other_host: true
      end
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

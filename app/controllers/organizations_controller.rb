class OrganizationsController < ApplicationController

    def new 
        @organization = Organization.new
        authorize @organization
    end

    def show
        @organization = Organization.find(params[:id])
        @wishlists = @organization.wishlists
        authorize @organization
    end

    def create
        @organization = Organization.find_by(organization_params.except(:logo)) || Organization.create(organization_params)
        authorize @organization
        if @organization.save
            current_user.update(organization: @organization)
            redirect_to wishlists_path
        else
            render :new
        end
    end

    def edit
        @organization = Organization.find(params[:id])
        authorize @organization
    end

    def update
        @organization = Organization.find(params[:id])
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
        @organization = Organization.find(params[:id])
        authorize @organization
        @organization.destroy
        flash[:notice] = "Organization deleted successfully"
        redirect_to root_path
    end

    private

    def organization_params
        params.require(:organization).permit(:name, :logo)
    end
end

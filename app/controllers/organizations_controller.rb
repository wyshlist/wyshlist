class OrganizationsController < ApplicationController

    def new 
        @organization = Organization.new
    end

    def create
        @organization = Organization.find_or_create_by(organization_params)
        if @organization
            current_user.update(organization: @organization)
            redirect_to wishlists_path
        else
            render :new
        end
    end

    def edit
        @organization = Organization.find(params[:id])
    end

    def update
        @organization = Organization.find(params[:id])
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
        @organization.destroy
        flash[:notice] = "Organization deleted successfully"
        redirect_to organizations_path
    end

    private

    def organization_params
        params.require(:organization).permit(:name, :logo)
    end
end

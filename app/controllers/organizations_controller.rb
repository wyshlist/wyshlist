class OrganizationsController < ApplicationController

    def new 
        @organization = Organization.new
    end

    def create
        @organization = Organization.find_or_create_by(organization_params).downcase
        if @organization
            current_user.update(organization: @organization)
            redirect_to wishlists_path
        else
            render :new
        end
    end

    private

    def organization_params
        params.require(:organization).permit(:name)
    end
end

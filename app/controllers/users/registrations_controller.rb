# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    build_resource(sign_up_params)
    stored_location = stored_location_for(resource)
    if stored_location.match?(/wishlists|wishes/)
      resource.update(user_since: DateTime.now)
      sign_in(resource)
      redirect_to stored_location
    else
      resource.update(team_member_since: DateTime.now, role: 1)
      sign_in(resource)
      redirect_to resource.is_super_team_member? ? new_organization_path : authenticated_root_path 
    end
  end
end

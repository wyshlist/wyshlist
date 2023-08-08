# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do |resource|
      if resource.persisted?
        # redirect_url = stored_location_for(resource) || request.referer || authenticated_root_url(subdomain: resource.organization.subdomain)
        redirect_url = authenticated_root_url(subdomain: resource.organization.subdomain)
        redirect_to redirect_url, allow_other_host: true and return
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

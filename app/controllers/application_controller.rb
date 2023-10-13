class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :set_wish_params, only: [:create]
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_organization
  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(authenticated_root_path)
  end

  private

  def set_wish_params
    if params["wish"].present?
      session[:wish_params] = params["wish"]
    end
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)|(^wishes$)|(^passthrough$)/
  end

  def set_organization
    Organization.find_by(subdomain: request.subdomain)
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo, :role])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :photo, :role])

    # For additional in app/views/devise/invitation/accept.html.erb
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name, :photo, :role])
  end

  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      !request.xhr? &&
      !turbo_frame_request?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def after_invite_path_for(_resource)
    members_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_organization_path(subdomain: '')
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.super_team_member? && !current_user.has_an_organization?
      new_organization_path
    else
      stored_location_for(resource_or_scope) || super
    end
  end
end

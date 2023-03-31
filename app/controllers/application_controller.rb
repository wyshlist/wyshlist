class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  
  private 

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

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || request.referer || root_path
  end
end

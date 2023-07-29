module ApplicationHelper
    def end_user_views?
        params[:controller] != "wishes" &&
        (params[:controller] != "organizations" && params[:action] != "show") &&
        params[:controller] != "users/registrations" &&
        params[:controller] != "users/sessions"
    end
end

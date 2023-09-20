module ApplicationHelper
    def end_user_views?
        disallowed_controllers = ["wishes", "organizations", "users/registrations", "devise/sessions", "pages"]
        !disallowed_controllers.include?(params[:controller])
    end
end

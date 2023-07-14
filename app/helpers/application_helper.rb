module ApplicationHelper
    def end_user_views?
        params[:controller] != "wishes" && (params[:controller] != "organizations" && params[:action] != "show")
    end
end

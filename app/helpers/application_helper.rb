module ApplicationHelper
    def dashboard_views?
        allowed_view_paths = ["/feedback", "/members", "/organizations", "wishes", "wishlists/new"]
        allowed_view_paths.include?(request.path)
    end
end

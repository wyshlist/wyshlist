class PassthroughController < ApplicationController
    def index
      path = case current_user.role
        when 'admin'
          rails_admin_path
        when 'team_member'
          feedback_url(subdomain: current_user.organization.subdomain)
        when 'super_team_member'
          feedback_url(subdomain: current_user.organization.subdomain)
        when 'user'
          wishlists_url(subdomain: request.subdomain)
        end
      redirect_to path, allow_other_host: true
    end
end

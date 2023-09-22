class PassthroughController < ApplicationController
    def index
      path = case current_user.role
        when 'admin'
          rails_admin_path
        when 'team_member'
          feedback_path
        when 'super_team_member'
          feedback_path
        when 'user'
          store_location_for(current_user)
        end
      redirect_to path
    end
end

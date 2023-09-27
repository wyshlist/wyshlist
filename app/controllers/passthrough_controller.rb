class PassthroughController < ApplicationController
  def index
    path = case current_user.role
           when 'admin'
             rails_admin_path
           when 'team_member', 'super_team_member'
             feedback_path
           when 'user'
             wishlists_path
           end
    redirect_to path
  end
end

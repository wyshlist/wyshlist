module ApplicationHelper
  def team_views?
    (params[:controller].match?(/organizations|invitations/) &&
      !(params[:controller].match?('organizations') && params[:action].match?('new'))) ||
      (params[:controller].match?('wishlists') && params[:action].match?('new')) ||
      (params[:controller].match?('users/registrations') && params[:action].match?('edit') && current_user.role != 'user')
  end

  def pages_view?
    (params[:controller].match?('organizations') && params[:action].match?('new')) ||
      params[:controller].match?(%r{pages|users/sessions}) ||
      (params[:controller].match?('users/registrations') && params[:action].match?(%r{new|create}))
  end

  def end_user_views?
    team_views? == false && pages_view? == false
  end
end

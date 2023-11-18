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
      (params[:controller].match?('users/registrations') && params[:action].match?('new'))
  end

  def end_user_views?
    team_views? == false && pages_view? == false
  end

  def sortable_link(text, column, direction)
    active = params[:order_column] == column && params[:order_direction] == direction
    link_to(text, request.params.merge(order_column: column, order_direction: direction), class: ('active' if active))
  end

  def filter_link(text, column)
    active = params[column] == text

    if params[column] == text
      link_to(text, request.params.merge(column => ''), class: ('active' if active))
    else
      link_to(text, request.params.merge(column => text), class: ('active' if active))
    end
  end

  def hidden_fields
    hidden_field_tag(:order_column, params[:order_column]) +
      hidden_field_tag(:order_direction, params[:order_direction]) +
      hidden_field_tag(:query, params[:query]) +
      hidden_field_tag(:stage, params[:stage]) +
      hidden_field_tag(:board, params[:board]) +
      hidden_field_tag(:start_date, params[:start_date]) +
      hidden_field_tag(:end_date, params[:end_date])
  end
end

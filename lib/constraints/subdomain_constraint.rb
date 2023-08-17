class SubdomainConstraint
  def self.matches?(request)
    return false if request.subdomain.nil? || request.subdomain == 'www'

    if request.params.key?(:id)
      model = request.controller_class.name.gsub("Controller", "").singularize.constantize.find(request.params[:id])
    elsif request.params.keys.grep(/.*_id/).any?
      key = request.params.keys.grep(/.*_id/).first
      model = key.gsub("_id", "").capitalize.constantize.find(request.params[key])
    else
      return Organization.select(:name).map(&:subdomain).include? request.subdomain
    end

    model = model.organization if model.respond_to?(:organization)
    (request.subdomain == model.subdomain)
  end
end

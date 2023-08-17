class SubdomainConstraint
  RESERVED_SUBDOMAINS = ['admin', 'www', 'test', 'staging']

  def self.matches?(request)
    RESERVED_SUBDOMAINS.exclude? request.subdomain
    # if request.params.key?(:id)
    #   model = request.controller_class.name.gsub("Controller", "").singularize.constantize.find(request.params[:id])
    # elsif request.params.keys.grep(/.*_id/).any?
    #   key = request.params.keys.grep(/.*_id/).first
    #   model = key.gsub("_id", "").capitalize.constantize.find(request.params[key])
    # else
    #   return Organization.select(:name).map(&:subdomain).include? request.subdomain
    # end

    # model = model.organization if model.respond_to?(:organization)
    # (request.subdomain == model.subdomain)
  end
end

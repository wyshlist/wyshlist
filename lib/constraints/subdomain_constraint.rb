class SubdomainConstraint
  def self.matches?(request)
    return false if request.subdomain.nil? || request.subdomain == 'www'

    if request.params.key?(:id)
      model = request.controller_class.name.gsub("Controller", "").singularize.constantize.find(request.params[:id])
    else
      key = request.params.keys.grep(/.*_id/).first
      model = key.gsub("_id", "").capitalize.constantize.find(request.params[key])
    end

    model = model.organization if model.respond_to?(:organization)

    (request.subdomain == model.subdomain)
  end
end

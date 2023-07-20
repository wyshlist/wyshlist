class SubdomainConstraint
  def self.matches?(request)
    # request.subdomain.present? && request.subdomain != 'www'
    Organization.find_by_request(request).present?
  end
end

class SubdomainConstraint
  RESERVED_SUBDOMAINS = ['admin', 'www', 'test', 'staging']

  def self.matches?(request)
    RESERVED_SUBDOMAINS.exclude? request.subdomain
  end
end

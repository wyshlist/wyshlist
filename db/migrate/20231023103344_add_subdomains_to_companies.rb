class AddSubdomainsToCompanies < ActiveRecord::Migration[7.0]
  def change
    Organization.all.each do |organization|
      organization.update(subdomain: organization.name.downcase.gsub(/\s+/, '-')) if organization.subdomain.nil?
      HerokuApi::SubdomainCreator.new(organization.subdomain).call
    end
  end
end

class AddIndexToOrganizationsSubdomain < ActiveRecord::Migration[7.0]
  def change
    add_index :organizations, :subdomain, unique: true
  end
end

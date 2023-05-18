class AddOrganizationToWishlists < ActiveRecord::Migration[7.0]
  def change
    add_reference :wishlists, :organization, null: true, foreign_key: true
  end
end

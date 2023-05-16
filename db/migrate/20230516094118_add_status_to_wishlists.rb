class AddStatusToWishlists < ActiveRecord::Migration[7.0]
  def change
    add_column :wishlists, :status, :string, default: 'active'
  end
end

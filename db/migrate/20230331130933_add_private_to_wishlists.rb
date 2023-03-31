class AddPrivateToWishlists < ActiveRecord::Migration[7.0]
  def change
    add_column :wishlists, :private, :boolean, default: false
  end
end

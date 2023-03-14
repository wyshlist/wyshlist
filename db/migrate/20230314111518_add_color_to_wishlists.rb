class AddColorToWishlists < ActiveRecord::Migration[7.0]
  def change
    add_column :wishlists, :color, :string, default: "3F4BF2"
  end
end

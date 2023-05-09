class AddVotesCountToWishlists < ActiveRecord::Migration[7.0]
  def change
    add_column :wishlists, :votes_count, :integer
  end
end

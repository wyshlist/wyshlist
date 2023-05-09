class AddVotesCountToWishes < ActiveRecord::Migration[7.0]
  def change
    add_column :wishes, :votes_count, :integer
  end
end

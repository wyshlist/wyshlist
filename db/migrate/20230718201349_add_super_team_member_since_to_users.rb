class AddSuperTeamMemberSinceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :super_team_member_since, :datetime
  end
end

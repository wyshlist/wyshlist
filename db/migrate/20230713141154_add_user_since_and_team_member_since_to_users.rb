class AddUserSinceAndTeamMemberSinceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :team_member_since, :datetime
  end
end

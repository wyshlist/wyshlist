class AddUserToWish < ActiveRecord::Migration[7.0]
  def change
    add_reference :wishes, :user, null: false, foreign_key: true
  end
end

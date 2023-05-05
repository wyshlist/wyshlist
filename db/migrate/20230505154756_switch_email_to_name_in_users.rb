class SwitchEmailToNameInUsers < ActiveRecord::Migration[7.0]
  def up
    User.find_each do |user|
      user.update_attribute(:first_name, user.email.split('@').first)
    end
  end
end

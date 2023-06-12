class AddColorToOrganizations < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :color, :string, default: "#000000"
  end
end

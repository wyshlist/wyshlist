class AddProjectAndWorkspaceToIntegrations < ActiveRecord::Migration[7.0]
  def change
    add_column :integrations, :project, :string
    add_column :integrations, :workspace, :string
  end
end

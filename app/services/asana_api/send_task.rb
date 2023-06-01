require 'asana'
require_relative '../application_service'
module AsanaApi
    class SendTask < ApplicationService
        def initialize(api_token)
            super(api_token)
            @client = AsanaApi::AsanaClient.new(@api_token).call
        end

        def call(workspace, project, task, description)
            @client.tasks.create_in_workspace(workspace: workspace, projects: [project], name: task, notes: description)
        end
    end
end
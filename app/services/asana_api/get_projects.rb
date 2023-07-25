require 'asana'
require_relative '../application_service'
module AsanaApi
    class GetProjects < ApplicationService
        def initialize(api_token)
            super(api_token)
            @client = AsanaApi::AsanaClient.new(@api_token).call
        end

        def call(workshop)
            @client.projects.get_projects(workspace: workshop.gid)
        end
    end
end
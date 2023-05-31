require 'asana'
require_relative '../application_service'
module AsanaApi
    class GetTasks < ApplicationService
        def initialize(api_token)
            super(api_token)
            @client = AsanaApi::AsanaClient.new(@api_token).call
        end

        def call(project)
            @client.tasks.find_by_project(project: project.gid)
        end
    end
end
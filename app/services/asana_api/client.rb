require 'asana'
require_relative '../application_service'
module AsanaApi 
    class AsanaClient < ApplicationService

        def call
            Asana::Client.new do |c|
                c.authentication :access_token, @api_token
                c.default_headers "asana-enable" => "new_goal_memberships"
            end
        end
    end

    class GetWorkshops < ApplicationService
        def initialize(api_token)
            super(api_token)
            @client = AsanaApi::AsanaClient.new(@api_token).call
        end

        def call
            @client.workspaces.find_all
        end
    end

    class GetProjects < ApplicationService
        def initialize(api_token)
            super(api_token)
            @client = AsanaApi::AsanaClient.new(@api_token).call
        end

        def call(workshop)
            @client.projects.get_projects(workspace: workshop.gid)
        end
    end

    class GetTasks < ApplicationService
        def initialize(api_token)
            super(api_token)
            @client = AsanaApi::AsanaClient.new(@api_token).call
        end

        def call(project)
            @client.tasks.find_by_project(project: project.gid)
        end
    end

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
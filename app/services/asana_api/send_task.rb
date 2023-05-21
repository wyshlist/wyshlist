require 'asana'
module AsanaApi < ApplicationSevice
    class Client
        def initialize(api_token)
            @api_token = api_token
        end

        def call
            Asana::Client.new do |c|
                c.authentication :access_token, @api_token
                c.default_headers "asana-enable" => "new_goal_memberships"
            end
        end
    end
end

client = AsanaApi::SendTask.new('1/1204496492204507:6be47a9c4b4fee3f78d359d69f4943a9').client
workspaces = client.workspaces.find_all
p projects = client.projects.get_projects(workspace: workspaces.first.gid)
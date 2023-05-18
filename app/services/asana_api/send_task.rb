require 'asana'
module AsanaApi
    class SendTask
        def initialize(api_token)
            @api_token = api_token
        end

        def call
            client = Asana::Client.new do |c|
                c.authentication :access_token, @api_token
                c.default_headers "asana-enable" => "new_goal_memberships"
            end
            results = client.projects.get_projects(options: {pretty: true})
            result = client.tasks.create_task(task_name: "Test", Description: "Test description", projects: result.first.titleize_name, options: {pretty: true})
        end
    end
end

p AsanaApi::SendTask.new('1/1204496492204507:6be47a9c4b4fee3f78d359d69f4943a9').call
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
end
require 'asana'
require_relative '../application_service'
module AsanaApi
  class GetWorkshops < ApplicationService
    def initialize(api_token)
      super(api_token)
      @client = AsanaApi::AsanaClient.new(@api_token).call
    end

    def call
      @client.workspaces.find_all
    end
  end
end

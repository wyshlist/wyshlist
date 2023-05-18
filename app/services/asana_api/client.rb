# module Asana
#     class Client < ApplicationService
#         BASE_URL = 'https://app.asana.com/api/1.0'
#         attr_reader :api_key, :adapter
#         def initialize(api_key:, adapter: Faraday.default_adapter)
#             @api_key = api_key
#             @adapter = adapter
#         end

#         def connection
#             @connection ||= Faraday.new(BASE_URL) do |conn|
#                 conn.url_prefix = BASE_URL
#                 conn.request :json
#                 conn.response :json, content_type: "application/json"
#                 conn.adapter adapter
#             end
#         end

#         def inspect
#             "#<Asana::Client>"
#         end
#     end
# end
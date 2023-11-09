require_relative '../application_service'
require 'faraday'
require 'json'
module HerokuApi
    class HerokuService < ApplicationService
        def initialize(subdomain)
            @base_url = "https://api.heroku.com/apps"
            @headers = headers
            @subdomain = subdomain.downcase
        end

        def headers
            {
                Accept: "application/vnd.heroku+json; version=3",
                Content_Type: "application/json",
                Authorization: "Bearer #{ENV['HEROKU_API_KEY']}",
                Accept_encoding: "utf8"
            }
        end

        def subdomain_exists?(data, subdomain)
            data.any? { |domain| domain["hostname"] == "#{subdomain}.wyshlist.net" }
        end

        def payload
            retries = 0
            begin
            Faraday.get("#{@base_url}/arcane-waters-65266/domains",{accept_encoding: "utf8"},  @headers)
            # raise AuthenticationError (si por alguna razon la authentication ha fallado)
            rescue AuthenticationError
                if (retries += 1) <= 3
                    retry
                end
            rescue URI::InvalidURIError => exception
                Rollbar.error(exception)
            rescue JSON::ParserError => exception
                Rollbar.error(exception)
            rescue Faraday::ConnectionFailed
                if (retries += 1) <= 3
                    sleep(retries * 3)
                    retry
                end
            end
        end
    end
end
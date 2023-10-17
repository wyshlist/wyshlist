require_relative 'application_service'
require 'faraday'
require 'json'

class SubdomainCreator < ApplicationService

    def initialize(subdomain)
        @base_url = "https://api.heroku.com/apps"
        @headers = headers
        @subdomain = subdomain.downcase
    end

    def headers
        {
            Accept: "application/vnd.heroku+json; version=3",
            Content_Type: "application/json",
            Authorization: "Bearer 682e356d-b131-4f6b-a881-a283acb8e64a",
            Accept_encoding: "utf8"
        }
    end

    # reload the partner because if the auth fails, the token get renew
    def call
        data = payload.body
        if subdomain_exists?(JSON.parse(data), @subdomain)
            puts "Subdomain already exists"
        else
            create_subdomain
        end
    end

    def create_subdomain
        body = {
            "hostname": "#{@subdomain}.wyshlist.net",
            "sni_endpoint": nil
        }
        body = body.to_json
        Faraday.post("#{@base_url}/arcane-waters-65266/domains", body, @headers)
    end

    def subdomain_exists?(data, subdomain)
        subdomain = false
        data.each do |heroku_domain|
            heroku_domain["name"] == subdomain ? subdomain = true : subdomain = false
        end
        subdomain
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

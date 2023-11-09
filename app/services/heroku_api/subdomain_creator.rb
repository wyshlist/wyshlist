module HerokuApi
    class SubdomainCreator < HerokuService
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
    end
end
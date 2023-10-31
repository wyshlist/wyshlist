module HerokuApi
    class SubdomainDeletor < HerokuService
        def call
            data = payload.body
            if subdomain_exists?(JSON.parse(data), @subdomain)
                delete_subdomain
            else
                puts "Subdomain doesn't exists"
            end
        end

        def delete_subdomain
            Faraday.delete("#{@base_url}/arcane-waters-65266/domains/#{@subdomain}.wyshlist.net", nil , @headers)
        end
    end
end
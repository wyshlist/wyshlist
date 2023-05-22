class PassthroughController < ApplicationController
    def index
        path = case current_user.role
            when ''
                wishlists_path
            when 'admin'
                admin_path
            else
                root_path
            end
            # If you want to raise an exception or have a default root for users without roles
        end

        redirect_to path     
    end
end

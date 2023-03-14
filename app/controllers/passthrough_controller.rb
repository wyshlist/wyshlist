class PassthroughController < ApplicationController
    def index
        path = case current_user.role
            when 'guest' || 'premium'
                wishlists_path
            when 'admin'
                admin_path
            # If you want to raise an exception or have a default root for users without roles
        end

        redirect_to path     
    end
end

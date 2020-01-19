class ApplicationController < ActionController::Base

    def home
    end

    private

    def ensure_theater_owner!
        if current_user.theater_owner
            return true 
        else
            return false
        end
    end

end

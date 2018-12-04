class HomeController < ApplicationController
    def lp
    end

    def index
    end

    def profile
    end

    def webmaster
        if current_user.status == 3
        else 
            redirect_to "home/index"
        end
    end

    def admin
        if current_user.status == 2
        else 
            redirect_to "home/index"
        end
    end
end

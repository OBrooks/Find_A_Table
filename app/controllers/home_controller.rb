class HomeController < ApplicationController

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

    def list_users
         session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                .find(session[:conversations])
                                end

    def scrapping
        Gamescrap.new.perform
    end
end

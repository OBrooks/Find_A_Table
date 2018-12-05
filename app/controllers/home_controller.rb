class HomeController < ApplicationController

    def index
    end

    def profile
    end

    def webmaster
        if current_user.webmaster?
        else 
            redirect_to "home/index"
        end
    end

    def admin
        if current_user.admin?
        else 
            redirect_to "home/index"
        end
    end

    def list_users
        @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
        @conversations = Conversation.involving(current_user).order("created_at DESC")
    end

    def scrapping
        Gamescrap.new.perform
    end
end

class HomeController < ApplicationController

    def index
    end

    def profile
    end

    def webmaster
        if current_user.webmaster?
        else 
            redirect_to root_path
        end
    end

    def admin
        if current_user.admin?
        else 
            redirect_to root_path
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

    def favoris
    @favoris=current_user.favorites
        if params[:id] != nil
            @games=Game.where(game_id: params[:id])
        end
    end

end

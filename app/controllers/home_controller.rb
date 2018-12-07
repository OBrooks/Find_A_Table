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

#Favoris part
    def favoris
    @favoris=current_user.favorites
    puts "Les params #{params}"
    @games=[]
    @favoris.each do |favor|
        @game=Game.find_by(id: favor.game_id)
        @games << @game
        puts "Le jeu favori est #{@game.title}"
    end
    puts "Le @games est #{@games}"
    end

    def add_to_favorites
        puts "#{params}"
      @user = User.find(params[:user_id])
      @game=Game.find(params[:game_id])
      puts "ça fav"
      respond_to do |format|
        format.html
        format.js {render :layout => false}
      end
    @favorite=Favorite.create!(user_id: current_user.id, game_id: params[:game_id])
  end

    def remove_from_favorites
      @user = User.find(params[:user_id])
      @game=Game.find(params[:game_id])
      puts "ça défav"
      respond_to do |format|
        format.html
        format.js {render :layout => false}
      end
    @favorite=Favorite.find_by(user_id: current_user.id, game_id: params[:game_id])
    @favorite.destroy
  end

#
end

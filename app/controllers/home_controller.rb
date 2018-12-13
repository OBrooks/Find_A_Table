class HomeController < ApplicationController

    def index
    end

    def profile
    end

    def list_users
    session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                .find(session[:conversations])
    end

#Favorites part

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

  #Favorites Games
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

  #Favorites Users
    def add_users_to_favorites
        puts "#{params}"
      @user = User.find(params[:user_id])
      puts "ça fav"
      respond_to do |format|
        format.html
        format.js {render :layout => false}
      end
    @favorite=FavoriteUser.create!(user_id: current_user.id, game_id: params[:game_id])
  end

    def remove_users_from_favorites
      @user = User.find(params[:user_id])
      puts "ça défav"
      respond_to do |format|
        format.html
        format.js {render :layout => false}
      end
    @favorite=FavoriteUser.find_by(user_id: current_user.id, game_id: params[:game_id])
    @favorite.destroy
  end

#Sessions
  def mysessions
    @myhostsessions = []
    @myplayersessions = []
    Session.all.each do |session|
      if session.host == current_user
        @myhostsessions << session
      end
      if session.players.include?(current_user)
        @myplayersessions << session
      end
    end
  end

  def player
    @player = User.find(params[:id])
        @common_sessions = []

        if current_user.sessions.ids == @player.sessions.ids
            @common_sessions << @player.sessions.ids
        end

  end
end

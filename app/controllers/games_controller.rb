class GamesController < ApplicationController

    def index
        if Game.all !=nil
            @games=Game.all
        end
    end

    def show
        @game=Game.find(params[:id])
      @favorites=Favorite.all
      if current_user != nil
        @favorite=Favorite.find_by(user_id: current_user.id, game_id: params[:id])
      end
    end

    def edit
        @game=Game.find(params[:id])
    end

end

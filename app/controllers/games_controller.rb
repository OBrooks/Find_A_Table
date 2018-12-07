class GamesController < ApplicationController

    def index
        if Game.all !=nil
            @games=Game.all
        end
    end

    def new
        @game = Game.new
    end

    def create
        Game.create!(title: params[:game][:title], description: params[:game][:description], image_url: params[:game][:image_url], min_players: params[:game][:min_players], max_players: params[:game][:max_players], time: "#{params[:game][:time]}" + " min", category: params[:game][:category])
        redirect_to games_path
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

    def update
        @game=Game.find(params[:id])
        @game.update(title: params[:game][:title], description: params[:game][:description], image_url: params[:game][:image_url], min_players: params[:game][:min_players], max_players: params[:game][:max_players], time: "#{params[:game][:time]}" + " min", category: params[:game][:category])
        redirect_to games_path
    end
end

class GamesController < ApplicationController

    def index
        if Game.all !=nil
            @games=Game.all
        end
    end

    def search_games
    end

    def new
        @game = Game.new
    end

    def create
        
        @game = Game.create(title: params[:title], description: params[:description], image_url: params[:image_url], min_players: params[:min_players], max_players: params[:max_players], time: "#{params[:time]}" + " min")

        if params[:new_category] != ""
            @current_category = Category.create!(category_name: params[:new_category])
            @game.update(category_id: @current_category.id)
        else
            @game.update(category_id: params[:category_name])
        end
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
<<<<<<< HEAD
        
        @game.update(title: params[:title], description: params[:description], image_url: params[:image_url], min_players: params[:min_players], max_players: params[:max_players], time: "#{params[:time]}" + " min")

        if params[:new_category] != ""
            @current_category = Category.create!(category_name: params[:new_category])
            @game.update(category_id: @current_category.id)
        else
            @game.update(category_id: params[:category_name])
        end
=======
        @game.update(title: params[:game][:title], description: params[:game][:description], image_url: params[:game][:image_url], game_picture: params[:game][:game_picture], min_players: params[:game][:min_players], max_players: params[:game][:max_players], time: "#{params[:game][:time]}" + " min", category: params[:game][:category])
>>>>>>> master
        redirect_to games_path
    end
end

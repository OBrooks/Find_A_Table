class GamesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def index
        if Game.all !=nil
            @games=Game.all
        end
    end

    def search_games
        if params[:query]
            @query = "%#{params[:query].downcase}%"
            @games = Game.where("title LIKE? or title LIKE? or description LIKE? or description LIKE?", @query.titleize, @query, @query.titleize, @query)
        end

        if params[:advanced_query]
            @query = "%#{params[:advanced_query].downcase}%"
            @max_players = params[:max_players].to_i + 1
            if @query == ""
                @searchgame = Game.all
            else
                @searchgame = Game.where("title LIKE? or title LIKE? or description LIKE? or description LIKE?", @query.titleize, @query, @query.titleize, @query)
            end
            @games = @searchgame.where("category_id = ?", params[:category])
            @games = @games.where("max_players < ?", @max_players)
        end
    end

    def advanced_search_games
    end

    def new
        @game = Game.new
    end

    def create
        
        @game = Game.create(title: params[:title], description: params[:description], image_url: params[:image_url], game_picture: params[:game_picture], min_players: params[:min_players], max_players: params[:max_players], time: "#{params[:time]}" + " min")

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
        
        @game.update(title: params[:title], description: params[:description], image_url: params[:image_url], game_picture: params[:game_picture], min_players: params[:min_players], max_players: params[:max_players], time: "#{params[:time]}" + " min")

        if params[:new_category] != ""
            @current_category = Category.create!(category_name: params[:new_category])
            @game.update(category_id: @current_category.id)
        else
            @game.update(category_id: params[:category_name])
        end
        redirect_to games_path
    end
end

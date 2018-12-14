class GamesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def index
        if Game.all !=nil
            @games=Game.order(created_at: :desc)
        end
    end

    def search_games
        if params[:query]
            @query = "%#{params[:query].downcase}%"
            @games = Game.where("title LIKE? or title LIKE? or description LIKE? or description LIKE?", @query.titleize, @query, @query.titleize, @query)
        end

        if params[:advanced_query]
            @query = "%#{params[:advanced_query].downcase}%"
            if @query == "%%"
                @games = Game.all
            else
                @games = Game.where("title LIKE? or title LIKE? or description LIKE? or description LIKE?", @query.titleize, @query, @query.titleize, @query)
            end
            if params[:category] != ""
                @games = @games.where("category_id = ?", params[:category])
            end
            if params[:max_players] != ""
                @max_players = params[:max_players].to_i + 1
                @games = @games.where("max_players < ?", @max_players)
            end
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
        if current_user.unwanted?
            redirect_to root_path, :flash => { :error => "Vous êtes considérés comme indésirable, contactez les administrateurs si vous voulez contester cette décision" }
        end
        @game=Game.find(params[:id])
        @gamecom = Gamecom.new
        @gamecoms = @game.gamecoms.order(created_at: :desc)
        @favorites=Favorite.all
        if current_user != nil
            @favorite=Favorite.find_by(user_id: current_user.id, game_id: params[:id])
        end
    end

    def edit
        if user_signed_in?
            if curent_user.unwanted?
                redirect_to root_path, :flash => { :error => "Vous êtes considérés comme indésirable, contactez les administrateurs si vous voulez contester cette décision" }
            end
        else
            redirect_to root_path, :flash => { :error => "Inscrivez vous ou connectez vous pour accéder à cette section" }
        end
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

    def destroy
        @game=Game.find(params[:id])
        @game.destroy
        redirect_to games_path
    end

    def create_comment
        if params[:gamecom][:score] == nil || params[:gamecom][:content] == ""
            redirect_to "/games/#{params[:gamecom][:game_id]}", :flash => { :error => "Vous devez laisser un commentaire et une note" }
        else
        Gamecom.create!(content: params[:gamecom][:content], user_id: params[:gamecom][:user_id], game_id: params[:gamecom][:game_id], score: params[:gamecom][:score])
        redirect_to "/games/#{params[:gamecom][:game_id]}"
        end
    end

    def update_comment
        @gamecomment = Gamecom.find_by(user_id: params[:gamecom][:user_id], game_id: params[:gamecom][:game_id])
        @gamecomment.update(content: params[:gamecom][:content], score: params[:gamecom][:score])
        redirect_to "/games/#{params[:gamecom][:game_id]}"
    end

    def destroy_comment
        Gamecom.find(params[:comment_id]).destroy
        redirect_to "/games/#{params[:game_id]}"
    end
end

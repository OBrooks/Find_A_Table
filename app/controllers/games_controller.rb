class GamesController < ApplicationController

    def index
        if Game.all !=nil
            @games=Game.all
        end
    end

    def show
    @game=Game.find(params[:id])
    end

end

class SessionController < ApplicationController
  def index
    @sessions = Session.all
  end

  def new
    @games = Game.all
    @users = User.all
    @session = Session.new
  end

  def create
    session=Session.create!(host_id: current_user.id, game_id: game)
  end

end

class GamesessionController < ApplicationController

  def index
    @sessions = Session.all
  end

  def show
    @session = Session.find(params[:id])
    @location = Geocoder.search(@session.city)
    @adress = Geocoder.search("#{@session.adress}, #{@session.city}")
  end

  def new
    @games = Game.all
    @users = User.all
    @session = Session.new
  end

  def create
    @ses = Session.new(host_id: current_user.id, game_id: params[:game], time: params[:time], date: params[:date], city: params[:city], adress: params[:adress], description: params[:description], playernb: params[:playernb].to_i, maxplayers: params[:maxplayers], status: params[:status].to_i, playerskill: params[:playerskill].to_i)
    if @ses.valid? && Geocoder.search("#{@ses.adress}, #{@ses.city}") != []
      @ses.save
      redirect_to gamesession_index_path
    else
      flash.now[:danger]="champsinvalide"
      render :new
    end
  end

  def edit
    @session = Session.find(params[:id])
  end

  def update
    @session = Session.find(params[:id])
    @session = @session.update(host_id: current_user.id, game_id: params[:game], time: params[:time], date: params[:date], city: params[:city], adress: params[:adress], description: params[:description], playernb: params[:playernb].to_i, maxplayers: params[:maxplayers], status: params[:status].to_i, playerskill: params[:playerskill].to_i)
    redirect_to gamesession_path
  end

  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    redirect_to gamesession_index_path
  end

  def joingame
    @session = Session.find(params[:id])
    @session.players << current_user
    @session.save
    redirect_back fallback_location: root_path
    flash[:notice]="SessionJoined"
  end

  def leavegame
    @session = Session.find(params[:id])
    @session.players.delete(current_user)
    @session.playernb -= 1
    if @session.playernb <= @session.maxplayers && @session.full?
      @session.available!
    end
    @session.save
    flash[:danger]="SessionLeft"
    redirect_to gamesession_index_path
  end

  def removerequest
    @session = Session.find(params[:id])
    @session.players.delete(current_user)
    @session.save
    flash[:danger]="RequestRemoved"
    redirect_to gamesession_index_path
  end

  def acceptrequest
    @session = Session.find(params[:session_id])
    @request = Request.find_by(user_id: params[:user_id], session_id: params[:session_id])
    @request.accepted!
    @session.playernb += 1
    if @session.playernb >= @session.maxplayers && @session.available?
      @session.full!
    end
    @session.save
    redirect_back fallback_location: root_path
  end

  def denyrequest
    @request = Request.find_by(user_id: params[:user_id], session_id: params[:session_id])
    @request.denied!
    @session.save
    redirect_back fallback_location: root_path
  end

end

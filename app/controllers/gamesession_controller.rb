class GamesessionController < ApplicationController

  before_action :unwanted_redirect
  skip_before_action :unwanted_redirect, :only => [:index, :not_signed_in]

  def unwanted_redirect
    if user_signed_in?
      if current_user.unwanted?
        redirect_to root_path, redirect_to root_path, :flash => { :error => "Vous êtes considérés comme indésirable, contactez les administrateurs si vous voulez contester cette décision" }
      end
    
    else
      redirect_to not_signed_in_path
    end
  end

  def not_signed_in
  end

  def index
    @sessions = Session.all
  end

  def search_sessions
    @city = "%#{params[:city].downcase}%"
    @game = "%#{params[:game].downcase}%"
    if @city == ""
      @sessions = Session.all
    else
      @sessions = Session.where("city LIKE? or city LIKE?", @city.titleize, @city)
    end

    if @game == ""
      @games = Game.all
    else
      @games = Game.where("title LIKE? or title LIKE? or description LIKE? or description LIKE?", @game.titleize, @game, @game.titleize, @game)
    end
    
    @sessions_array = []
    @sessions.each do |session|
      @games.each do |game|
        if game.id == session.game_id
          @sessions_array << session
        end
      end
    end

    puts "ICIIIIIIIIIIIIIIIIIIIIIIIIi"
    puts @sessions_array
  end

  def show
    @session = Session.find(params[:id])
    @chatroom = Chatroom.find_by(session_id: params[:id])
    
    @location = Geocoder.search(@session.city)
    @adress = Geocoder.search("#{@session.adress}, #{@session.city}")
    @circle= [(@location.first.coordinates[0]+@adress.first.coordinates[0])/2,(@location.first.coordinates[1]+@adress.first.coordinates[1])/2]
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
    @chatroom = Chatroom.create!(session_id: @ses.id)
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
    @chatroom = Chatroom.find_by(session_id: params[:id])
    puts "Le chatroom est #{@chatroom}"
    @chatroom_user = ChatroomUser.where(user_id: current_user.id, chatroom_id: @chatroom.id).first_or_create
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

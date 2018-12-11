class HomeController < ApplicationController
  def index
    Cryptomon.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!("cryptomons")
    StartScrap.new.perform
    @cryptos = Cryptomon.all
    @cryptomon = Cryptomon.new
  end

  def put
    @crypto = Cryptomon.find(params[:cryptomon][:id])
  end
end

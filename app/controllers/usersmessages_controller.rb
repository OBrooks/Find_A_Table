class UsersmessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def create
    usersmessage = @chatroom.usersmessages.new(message_params)
    usersmessage.user = current_user
    usersmessage.save
    MessageRelayJob.perform_later(usersmessage)
  end

  private

    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end

    def message_params
      params.require(:usersmessage).permit(:body)
    end
end

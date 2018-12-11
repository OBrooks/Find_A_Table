class ChatroomUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom


  def destroy
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
    redirect_to chatrooms_path
  end

  private

    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end
end

class ConversationsController < ApplicationController

  def show
    @conversations_senders = Conversation.where(sender_id: current_user.id)
    @conversations_recipients = Conversation.where(recipient_id: current_user.id)
    @conversations_senders
    @conversations_recipients
      puts "Voilà les conversations #{@conversations}"
      @chatroom_users=ChatroomUser.where(user_id: current_user.id)
      puts "Voilà le chatroom_users#{@chatroom_users}" 

  end

  def conversation_user
      if params[:conversation_id] != nil && params[:user_id] != nil
      @conversation=Conversation.find(params[:conversation_id])
      @user=User.find(params[:user_id])
    end
    respond_to do |format|
        format.html
        format.js {render :layout => false}
      end
  end
  
  def create
    @conversation = Conversation.get(current_user.id, params[:user_id])

    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end

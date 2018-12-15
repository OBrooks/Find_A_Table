class ConversationsController < ApplicationController

  def show
    @conversations_senders = Conversation.where(sender_id: current_user.id)
    @conversations_recipients = Conversation.where(recipient_id: current_user.id)
    @conversations_senders
    @conversations_recipients
      @chatroom_users=ChatroomUser.where(user_id: current_user.id)

  end

  def conversation_user
  @users_favorites=FavoritesUser.where(adder_id: current_user.id)
      
    @users_favorites.each do |user_favorite|      
        @conversation_sender = Conversation.find_by(sender_id: current_user.id, recipient_id: user_favorite.added.id)
        @conversation_recipient = Conversation.find_by(recipient_id: current_user.id, sender_id: user_favorite.added.id)
          if @conversation_sender == nil && @conversation_recipient == nil
            Conversation.create!(sender_id: current_user.id, recipient_id: user_favorite.added.id)
          end
        end

    @converses=Conversation.all
    if params[:conversation_id] != nil && params[:user_id] != nil && @converses != nil
      @user=User.find(params[:user_id])
      @conversation_last_id=Conversation.maximum(:id).next
      if params[:conversation_id].to_i == @conversation_last_id.to_i
        Conversation.create!(sender_id: current_user.id, recipient_id: @user.id)
         @conversation=Conversation.find(params[:conversation_id])
      else
        @conversation=Conversation.find(params[:conversation_id])
      end
    else 
      Conversation.create!(sender_id: current_user.id, recipient_id: @user.id)
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

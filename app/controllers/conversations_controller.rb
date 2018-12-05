class ConversationsController < ApplicationController
  def create
    puts "in the start of create"
    @conversation = Conversation.get(current_user.id, params[:user_id])

    add_to_conversations unless conversated?
    puts "in create before respond_to"
    respond_to do |format|
      format.js
    end
    puts "in create after respond_to"
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

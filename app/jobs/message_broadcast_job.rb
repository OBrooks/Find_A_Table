class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)

    puts ""
    puts ""
    puts "MessageBroadcastJob perform début"
    puts ""
    puts ""
    puts "Message is #{message}#"
    puts ""
    puts "Message body is #{message.body}#"
    puts ""
    puts "Message.user is #{message.user}"
    puts "Message conversation is #{message.conversation}"
    puts ""
    sender = message.user
    recipient = message.conversation.opposed_user(sender)
    puts "Recipient is #{recipient}"
    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)
    puts ""
    puts ""
    puts "MessageBroadcastJob perform fin"
    puts ""
    puts ""
  end

  private

  def broadcast_to_sender(user, message)
    puts ""
    puts "Supposé broadcast_to_sender début"
    puts "Le message body broadcast sender est #{message.body}"
    message2=ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
    puts "User Id du sender is#{user.nickname}"
    puts ""
    puts "User Id du receiver is#{message.conversation.opposed_user(user).nickname}"
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      message: message2,
      conversation_id: message.conversation_id,
      sender_name: user.nickname
    )
    
        puts ""
        puts "Supposé broadcast_to_sender fin"
  end

  def broadcast_to_recipient(user, message)
    puts ""
    puts "Supposé broadcast_to_recipient début"
    message2=ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
    puts "User receiver is#{user.nickname}"
    puts ""
    puts "User du sender side recipient is#{message.conversation.opposed_user(user).nickname}"
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      message: message2,
      conversation_id: message.conversation_id,
      recipient_name: user.nickname,
      sender_name: message.conversation.opposed_user(user).nickname
    )
    
    puts ""
    puts "Supposé broadcast_to_recipient fin"
  end

  def render_message(message, user)
    puts ""
    puts "Supposé render message début"
    puts ""
    puts "Message in is #{message.body}"
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
        puts "Supposé render message fin"
  end

  def render_window(conversation, user)
        puts ""
        puts "Supposé render window début"
        puts ""
        puts "Conversation is#{conversation}"
    ApplicationController.render(
      partial: 'conversations/conversation',
      locals: { conversation: conversation, user: user }
    )
        puts ""
            puts "Supposé render window fin"
  end
end

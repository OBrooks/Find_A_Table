# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ConversationChannel < ApplicationCable::Channel
  def subscribed
    puts ""
    puts "inside ConversationChannel subscribed"
    stream_from "conversations-#{current_user.id}"
  end

  def unsubscribed
    puts ""
    puts "inside ConversationChannel unsubscribed"
    stop_all_streams
  end

  def speak(data)
    puts ""
    puts "inside ConversationChannel speak"
    puts "#{data}"
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end
    puts ""
    puts ""
    puts "inside speak Method of Conversation_channel with #{message_params}"
    puts ""
    Message.create(message_params)
    puts ""
    puts "after Message.create"
  end
end

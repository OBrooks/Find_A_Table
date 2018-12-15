class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(usersmessage)
    ActionCable.server.broadcast("chatrooms:#{usersmessage.chatroom.id}",
    usersmessage: UsersmessagesController.render(usersmessage),
    chatroom_id: usersmessage.chatroom.id,
    )
  end
end

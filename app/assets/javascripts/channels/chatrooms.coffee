App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
  console.log "connected"
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log "inside received"
    active_chatroom = $("[data-behavior='usersmessages'][data-chatroom-id='#{data.chatroom_id}']")
    active_chatroom.append(data.usersmessage)

    # Called when there's incoming data on the websocket for this channel

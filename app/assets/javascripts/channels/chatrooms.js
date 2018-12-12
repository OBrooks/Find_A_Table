App.chatrooms = App.cable.subscriptions.create ("ChatroomsChannel",{
  connected: function () {},
  disconnected: function () {},
  received: function (data) {
    console.log(data)
    console.log('voici chatroom_id', data['chatroom_id'])
    console.log('voici data-chatroom-id',"[data-chatroom-id='" + data['chatroom_id'] + "']")

    let active_chatroom = $("#usersmessages").find("[data-chatroom-id='" + data['chatroom_id'] + "']");

    console.log(active_chatroom)
    console.log(data['usersmessage'])

    active_chatroom.find('ul').append(data['usersmessage']);
    
    console.log("c'est good")
    console.log(active_chatroom)
  }

});


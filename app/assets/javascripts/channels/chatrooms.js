App.chatrooms = App.cable.subscriptions.create ("ChatroomsChannel",{
  connected: function () {},
  disconnected: function () {},
  received: function (data) {

    var active_chatroom = $("#usersmessages").find("[data-chatroom-id='" + data['chatroom_id'] + "']");

    active_chatroom.find('ul').append(data['usersmessage']);

  }

});


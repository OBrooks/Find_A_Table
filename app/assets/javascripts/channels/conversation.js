App.conversation = App.cable.subscriptions.create("ConversationChannel", {
  connected: function () {},
  disconnected: function () {},
  received: function (data) {
    console.log("on est dans le received")
    console.log(data)
    console.log(data['message'])
    var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
    console.log("inside conversation.js ActionCable")
    if (data['window'] !== undefined) {
      var conversation_visible = conversation.is(':visible');
    console.log("inside conversation.js ActionCable window defined")
      if (conversation_visible) {
        var messages_visible = (conversation).find('.panel-body').is(':visible');
        if (!messages_visible) {
          conversation.removeClass('panel-default').addClass('panel-success');
        }
        conversation.find('.messages-list').find('ul').append(data['message']);
      } else {
        $('#conversations-list').append(data['window']);
        conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
        conversation.find('.panel-body').toggle();
      }
    } else {
      console.log("inside conversation.js ActionCable window undefined")
      console.log(data)
      console.log(conversation)
      conversation.find('ul').append(data['message']);
    }

    var messages_list = conversation.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },
  speak: function (message) {
    console.log("2 inside speak function")
    console.log(this)
    console.log(message)
    console.log("c'était this")
    return this.perform('speak', {
      message: message
    })
    ;
  }
});
$(document).on('submit', '.new_message', function (e) {
  console.log("1 inside submit .new_message")
  e.preventDefault();
  var values = $(this).serializeArray();
  App.conversation.speak(values);
  $(this).trigger('reset');
});

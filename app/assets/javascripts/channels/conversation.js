App.conversation = App.cable.subscriptions.create("ConversationChannel", {
  connected: function () {},
  disconnected: function () {},
  received: function (data) {
    console.log("on est dans le received")
    console.log(data)
    console.log("message", data['message'])
    console.log("conversation_id", data['conversation_id'])
    
    var conversation = $('#conversation-messages-user-to-user').find("[data-conversation-id='" + data['conversation_id'] + "']");
    var conversation_list_users = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
    
    console.log("inside conversation.js ActionCable")
    console.log("voici conversation", conversation)
    console.log("voici conversation_list_users", conversation_list_users)
    
    if ($(".panel-heading").is(':visible')) {
      var conversation_visible = conversation.is(':visible');
      
      console.log("inside conversation.js ActionCable window defined")
      console.log("conversation_visible",conversation_visible)

      if (conversation_visible) {
        var messages_visible = (conversation).find('.panel-body').is(':visible');
        
        console.log("inside conversation_visible")
        console.log("messages_visible",messages_visible)
        
        if (!messages_visible) {
          
          console.log("inside !messages_visible")
          
          conversation.removeClass('panel-default').addClass('clign');
        }
        conversation.find('.messages-list').find('ul').append(data['message']);
      } else {
        
        console.log("voici les datas")
        console.log(data)
        
        $('#conversations-list').append('New message from ', data['sender_name']);
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
    
    console.log("voilà la message_list")
    console.log(messages_list)
    
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

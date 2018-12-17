App.conversation = App.cable.subscriptions.create("ConversationChannel", {
  connected: function () {},
  disconnected: function () {},
  received: function (data) {
    
    var conversation = $('#conversation-messages-user-to-user').find("[data-conversation-id='" + data['conversation_id'] + "']");
    var conversation_list_users = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
    
    
    if ($(".messenger-heading").is(':visible')) {
      var conversation_visible = conversation.is(':visible');
      

      if (conversation_visible) {
        var messages_visible = (conversation).find('.messenger-body').is(':visible');
        
        
        if (!messages_visible) {
          
          
          conversation.removeClass('.messenger-default').addClass('clign');
        }
        conversation.find('.messages-list').find('ul').append(data['message']);
      } else {
        
        
        $('#conversations-list').append('New message from ', data['sender_name']);
        conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
        conversation.find('.messenger-body').toggle();
      }
    } else {
      
      
      conversation.find('ul').append(data['message']);
    }

    var messages_list = conversation.find('.messages-list');
    
    
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },
  speak: function (message) {
    
    
    return this.perform('speak', {
      message: message
    })
    ;
  }
});
$(document).on('submit', '.new_message', function (e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.conversation.speak(values);
  $(this).trigger('reset');
});

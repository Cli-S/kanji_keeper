function hasIdOrNot() {
  if (document.getElementById("messages") != null) {
    const chatRoomId = document.querySelector("#messages").dataset.chatRoomId;
    App.room = App.cable.subscriptions.create({
      channel: "RoomChannel",
      chat_room_id: chatRoomId
    }, 
      {
      connected() {},
        // Called when the subscription is ready for use on the server

      disconnected() {},
        // Called when the subscription has been terminated by the server

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        $('#messages').append(data['message']);
        scrollBottom();
      },

      speak(message, chat_room_id) {
        return this.perform('speak', {message: message, chat_room_id: chat_room_id});
        }
      }
    );

    $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
      if (event.keyCode === 13) { // return = send
        App.room.speak(event.target.value, chatRoomId);
        event.target.value = '';
        return event.preventDefault();
      }
    });

    function scrollBottom() {
      return $('#public-chat-messages').scrollTop($('#public-chat-messages')[0].scrollHeight);
    };    
  }
}

hasIdOrNot();
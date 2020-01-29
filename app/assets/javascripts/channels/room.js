const currentUserId = document.querySelector("meta[name='currentUserId']").content;

document.querySelectorAll(".message").forEach((message) => {
  styleMessageAccordingToCurrentUser(message, currentUserId);
});

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
        const newMessageElement = document.querySelector(".message:last-child")
        styleMessageAccordingToCurrentUser(newMessageElement, currentUserId);
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

  }
}

function scrollBottom() {
  if (document.querySelector('#public-chat-messages')) {
    $('#public-chat-messages').scrollTop($('#public-chat-messages')[0].scrollHeight);
  }
};

function styleMessageAccordingToCurrentUser(messageElement, currentUserId) {
  const individualPublicMessage = messageElement.querySelector(".individual-public-message");
  const userMessage = messageElement.querySelector(".user-messages");
  const userDate = messageElement.querySelector(".user-date");
  const userDelete = messageElement.querySelector(".message-delete");

  if (messageElement.dataset.senderId === currentUserId) {
    individualPublicMessage.classList.add("current");
    userMessage.classList.add("current");
    userDate.classList.add("current");
  } else {
    individualPublicMessage.classList.add("other");
    userMessage.classList.add("other");
    userDate.classList.add("other");
    userDelete.classList.add("invisible-delete");
  }
}

hasIdOrNot();
scrollBottom();
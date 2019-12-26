class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # TODO: You should only be able to subscribe to a channel that you are a part of, if statement
    stream_from "room_channel_#{params['chat_room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    current_user.messages.create!(content: data['message'], chat_room_id: data['chat_room_id'])
  end
end

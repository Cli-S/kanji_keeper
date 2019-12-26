class ChatRoomUsersController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @user = User.find(params[:user_id])
    @chat_room_user = ChatRoomUser.new(user: @user, chat_room: @chat_room)

    if !@chat_room_user.save
      flashes[:alert] = "Invalid chat room user, please contact Cli if you think this is a mistake."
    end

    redirect_to chat_room_path(@chat_room)
  end
end

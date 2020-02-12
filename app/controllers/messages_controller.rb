class MessagesController < ApplicationController
  def destroy
    @message = Message.find(params[:id])
    if @message.user == current_user
      @message.destroy
      #@chat_room = ChatRoom.find(params[:chat_room_id])
      redirect_to chat_path
      #redirect_to chat_room_path(@chat_room.id)
    end
  end
end

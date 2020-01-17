class ChatRoomsController < ApplicationController

  def index
    @chat_rooms = current_user.chat_rooms

    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @chat_room_user = ChatRoomUser.new
    @message = Message.new
    @messages = Message.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.new(chat_room_params)
    @chat_room.user = current_user
    @chat_room.chat_room_users.new(user: current_user)

    if @chat_room.save!
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @chat_room_user = ChatRoomUser.new
    @message = Message.new
    @messages = Message.all
  end

  def edit

  end

  def destroy
    @chat_room_owner = ChatRoom.find(params[:id]).user_id
    if current_user.id == ChatRoom.find(params[:id]).user_id
      @chat_room = ChatRoom.find(params[:id])
      @chat_room.destroy!
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :content)
  end
end

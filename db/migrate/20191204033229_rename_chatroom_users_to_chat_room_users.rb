class RenameChatroomUsersToChatRoomUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :chatroom_users, :chat_room_users
  end
end

class CreateChatroomUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :chatroom_users do |t|
      t.references :chat_room, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

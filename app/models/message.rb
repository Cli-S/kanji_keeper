class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  after_create_commit { MessageBroadcastJob.perform_later self }
  validates :content, presence: true, length: {minimum: 1, maximum: 280}
  scope :for_display, -> { order(:created_at).last(5) }
end

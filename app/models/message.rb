class Message < ApplicationRecord
  belongs_to :user
  after_create_commit { MessageBroadcastJob.perform_later self }
  validates :content, presence: true, length: {minimum: 1, maximum: 1000}
end

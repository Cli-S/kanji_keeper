class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications
  validates :content, presence: true, length: {minimum: 1}
end

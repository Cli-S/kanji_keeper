class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, format: { with: /\A[a-zA-Z0-9_\-]+\z/, message: "can only contain letters, numbers, - and _" }
  has_many :posts
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :chat_room_users
  has_many :chat_rooms, dependent: :destroy, through: :chat_room_users
  scope :all_except, ->(user) { where.not(id: user) }
  has_many :messages, dependent: :destroy
  has_many :notifications
  mount_uploader :avatar, PhotoUploader
  validates :bio, length: { maximum: 150 }
end
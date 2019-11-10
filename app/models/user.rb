class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, format: { with: /[a-zA-Z0-9_\-]/, message: "can only contain letters, numbers, - and _" }
  has_many :posts
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  mount_uploader :avatar, PhotoUploader
end
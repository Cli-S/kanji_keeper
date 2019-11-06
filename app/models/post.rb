class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  mount_uploader :photo, PhotoUploader

  scope :privates, -> { where(private: true) }
  scope :publics, -> { where(private: false) }
end

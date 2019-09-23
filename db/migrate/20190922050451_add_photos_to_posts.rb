class AddPhotosToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column(:posts, :photo, :string)
  end
end

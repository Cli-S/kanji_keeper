class SetDefaultToPublic < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :private, :boolean, default: false
  end
end

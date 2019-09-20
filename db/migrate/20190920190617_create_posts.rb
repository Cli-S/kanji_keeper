class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :expression
      t.text :reading
      t.text :meaning
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

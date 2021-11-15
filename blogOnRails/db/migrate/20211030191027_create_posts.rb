class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null:false
      t.text :body, null:false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts, :id, unique:true
  end
end

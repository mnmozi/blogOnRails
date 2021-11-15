class AddIndexToPostsTags < ActiveRecord::Migration[6.1]
  def change
    add_index :posts_tags, ["post_id", "tag_id"], :unique => true
  end
end

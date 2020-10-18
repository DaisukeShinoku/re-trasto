class CreateStoryBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :story_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end
    add_index :story_bookmarks, [:user_id, :story_id], unique: true
  end
end

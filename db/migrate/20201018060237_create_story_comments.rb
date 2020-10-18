class CreateStoryComments < ActiveRecord::Migration[5.2]
  def change
    create_table :story_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
    add_index :story_comments, [:user_id, :story_id, :created_at]
  end
end

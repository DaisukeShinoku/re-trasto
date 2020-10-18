class CreateTweetComments < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
    add_index :tweet_comments, [:user_id, :tweet_id, :created_at]
  end
end

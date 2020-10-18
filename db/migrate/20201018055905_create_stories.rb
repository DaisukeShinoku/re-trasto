class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :house, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.date :visit_date, null: false
      t.string :story_image

      t.timestamps
    end
    add_index :stories, [:user_id, :house_id, :created_at]
  end
end

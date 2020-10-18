class CreateHouseComments < ActiveRecord::Migration[5.2]
  def change
    create_table :house_comments do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :house, null: false, foreign_key: true

      t.timestamps
    end
    add_index :house_comments, [:user_id, :house_id, :created_at]
  end
end

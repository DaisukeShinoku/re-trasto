class CreateToGoLists < ActiveRecord::Migration[5.2]
  def change
    create_table :to_go_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :house, null: false, foreign_key: true

      t.timestamps
    end
    add_index :to_go_lists, [:user_id, :house_id], unique: true
  end
end

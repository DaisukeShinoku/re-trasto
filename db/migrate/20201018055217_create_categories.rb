class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :category_image
      t.boolean :is_valid, default:true, null: false
      t.timestamps
    end
  end
end

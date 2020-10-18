class CreateHouseCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :house_categories do |t|
      t.references :house, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end

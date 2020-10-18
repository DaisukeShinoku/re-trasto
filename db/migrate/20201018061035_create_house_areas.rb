class CreateHouseAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :house_areas do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end

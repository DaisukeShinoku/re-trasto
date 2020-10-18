class AddReferencesToHouses < ActiveRecord::Migration[5.2]
  def change
    add_reference :houses, :house_area, null: false, foreign_key: true
  end
end

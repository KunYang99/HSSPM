class CreateMainLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :main_locations do |t|
      t.string :name
      t.text :location
      t.text :note

      t.timestamps
    end
  end
end

class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.string :title
      t.string :file
      t.string :note

      t.timestamps
    end
  end
end

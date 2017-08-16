class CreateDatasets < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets do |t|
      t.references :human, index: true
      t.string :title
      t.string :file
      t.text :availability
      t.text :contributors
      t.string :pi
      t.string :note

      t.timestamps
    end
  end
end

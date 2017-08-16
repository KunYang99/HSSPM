class CreateHumen < ActiveRecord::Migration[5.0]
  def change
    create_table :humen do |t|
      t.string :accession
      t.text :other_ids
      t.references :population, index: true
      t.references :gender, index: true
      t.text :note
      t.references :status, index: true

      t.timestamps
    end
  end
end

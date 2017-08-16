class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.references :human, index: true
      t.references :visit_type, index: true
      t.text :diagnosis
      t.boolean :sans
      t.boolean :neuropsycho
      t.text :note

      t.timestamps
    end
  end
end

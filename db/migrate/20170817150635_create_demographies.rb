class CreateDemographies < ActiveRecord::Migration[5.0]
  def change
    create_table :demographies do |t|
      t.references :human, foreign_key: true
      t.text :data, limit: 4294967295

      t.timestamps
    end
  end
end

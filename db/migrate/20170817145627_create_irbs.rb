class CreateIrbs < ActiveRecord::Migration[5.0]
  def change
    create_table :irbs do |t|
      t.string :number
      t.text :name
      t.string :pi
      t.text :note

      t.timestamps
    end
  end
end

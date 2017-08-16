class CreateHumanSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :human_samples do |t|
      t.references :sample_type, index:true
      t.references :visit, index:true
      t.string :amount
      t.date :created_on
      t.references :main_location, index:true
      t.string :sub_location
      t.string :source
      t.string :prepared_by

      t.timestamps
    end
  end
end

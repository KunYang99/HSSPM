class CreateClinicFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :clinic_files do |t|
      t.string :title
      t.string :file
      t.text :note

      t.timestamps
    end
  end
end

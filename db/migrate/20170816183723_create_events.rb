class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start
      t.datetime :stop
      t.string :place
      t.text :note

      t.timestamps
    end
  end
end

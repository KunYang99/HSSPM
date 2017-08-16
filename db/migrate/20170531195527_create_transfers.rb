class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.references :human_sample, foreign_key: true
      t.string :trans_type
      t.string :trans_to
      t.string :amount
      t.text :note

      t.timestamps
    end
  end
end

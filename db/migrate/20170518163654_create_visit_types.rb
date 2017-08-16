class CreateVisitTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :visit_types do |t|
      t.string :value

      t.timestamps
    end
  end
end

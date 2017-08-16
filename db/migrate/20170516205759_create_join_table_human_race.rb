class CreateJoinTableHumanRace < ActiveRecord::Migration[5.0]
  def change
    create_join_table :humen, :races do |t|
      t.index [:human_id, :race_id]
      # t.index [:race_id, :human_id]
    end
  end
end

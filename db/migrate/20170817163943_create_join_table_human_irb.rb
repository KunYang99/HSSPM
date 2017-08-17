class CreateJoinTableHumanIrb < ActiveRecord::Migration[5.0]
  def change
    create_join_table :humen, :irbs do |t|
      t.index [:human_id, :irb_id]
      # t.index [:irb_id, :human_id]
    end
  end
end

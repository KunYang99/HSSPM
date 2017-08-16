class CreateJoinTableHumanCohort < ActiveRecord::Migration[5.0]
  def change
    create_join_table :humen, :cohorts do |t|
      t.index [:human_id, :cohort_id]
      # t.index [:cohort_id, :human_id]
    end
  end
end

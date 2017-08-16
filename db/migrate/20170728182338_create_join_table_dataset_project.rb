class CreateJoinTableDatasetProject < ActiveRecord::Migration[5.0]
  def change
    create_join_table :datasets, :projects do |t|
      t.index [:dataset_id, :project_id]
      # t.index [:project_id, :dataset_id]
    end
  end
end

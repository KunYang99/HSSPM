class AddNoteToHumanSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :human_samples, :note, :text
  end
end

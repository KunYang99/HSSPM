class AddAccessionToHumanSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :human_samples, :accession, :string
  end
end

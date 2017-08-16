class AddConcentrationToHumanSample < ActiveRecord::Migration[5.0]
  def change
    add_column :human_samples, :concentration, :string
  end
end

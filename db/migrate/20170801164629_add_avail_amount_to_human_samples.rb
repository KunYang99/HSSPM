class AddAvailAmountToHumanSamples < ActiveRecord::Migration[5.0]
  def change
    add_column :human_samples, :avail_amount, :string
  end
end

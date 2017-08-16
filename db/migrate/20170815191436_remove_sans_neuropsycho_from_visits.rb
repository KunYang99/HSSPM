class RemoveSansNeuropsychoFromVisits < ActiveRecord::Migration[5.0]
  def change
    remove_column :visits, :sans, :boolean
    remove_column :visits, :neuropsycho, :boolean
  end
end

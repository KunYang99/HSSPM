class AddAgeToVisit < ActiveRecord::Migration[5.0]
  def change
    add_column :visits, :age, :integer
  end
end

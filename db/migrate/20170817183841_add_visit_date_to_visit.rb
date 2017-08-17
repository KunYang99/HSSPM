class AddVisitDateToVisit < ActiveRecord::Migration[5.0]
  def change
    add_column :visits, :visit_date, :date
  end
end

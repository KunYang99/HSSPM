class CreateFavSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :fav_subjects do |t|
      t.references :user, index: true
      t.references :human, index: true

      t.timestamps
    end
  end
end

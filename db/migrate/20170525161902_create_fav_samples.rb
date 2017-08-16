class CreateFavSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :fav_samples do |t|
      t.references :user, index: true
      t.references :human_sample, index: true

      t.timestamps
    end
  end
end

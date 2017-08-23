class AddAddressToIrb < ActiveRecord::Migration[5.0]
  def change
    add_column :irbs, :address, :string
  end
end

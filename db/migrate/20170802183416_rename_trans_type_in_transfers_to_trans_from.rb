class RenameTransTypeInTransfersToTransFrom < ActiveRecord::Migration[5.0]
  def change
    rename_column :transfers, :trans_type, :trans_from
  end
end

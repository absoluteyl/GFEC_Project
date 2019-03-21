class RenameShippingsToLocations < ActiveRecord::Migration[5.2]
  def change
    rename_table :shippings, :locations
  end
end

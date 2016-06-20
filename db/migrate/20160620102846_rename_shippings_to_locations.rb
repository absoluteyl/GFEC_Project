class RenameShippingsToLocations < ActiveRecord::Migration
  def change
    rename_table :shippings, :locations
  end
end

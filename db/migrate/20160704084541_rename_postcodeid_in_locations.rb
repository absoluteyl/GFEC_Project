class RenamePostcodeidInLocations < ActiveRecord::Migration
  def change
    rename_column :locations, :postcode_id, :city_id
    rename_column :cities, :city_id, :parent_id
  end
end

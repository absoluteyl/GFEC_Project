class AddAliasToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :alias, :string
  end
end

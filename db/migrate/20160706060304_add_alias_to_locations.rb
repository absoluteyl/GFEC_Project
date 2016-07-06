class AddAliasToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :alias, :string
  end
end

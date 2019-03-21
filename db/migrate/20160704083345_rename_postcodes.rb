class RenamePostcodes < ActiveRecord::Migration[5.2]
  def self.up
    rename_table :postcodes, :cities
  end

  def self.down
    rename_table :cities, :postcodes
  end
end

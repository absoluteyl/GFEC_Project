class AddMobileToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :mobile, :string
  end
end

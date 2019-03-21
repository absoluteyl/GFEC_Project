class AddMobileToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :mobile, :string
  end
end

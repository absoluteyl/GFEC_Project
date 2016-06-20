class AddCityIdInPostcodes < ActiveRecord::Migration
  def change
    add_column :postcodes, :city_id, :integer
  end
end

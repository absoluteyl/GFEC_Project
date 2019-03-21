class AddCityIdInPostcodes < ActiveRecord::Migration[5.2]
  def change
    add_column :postcodes, :city_id, :integer
  end
end

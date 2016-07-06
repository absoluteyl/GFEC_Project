class AddLocationToMerchandises < ActiveRecord::Migration
  def change
    add_column :merchandises, :location_id, :integer
    change_column :line_items, :unit_price, :integer
  end
end

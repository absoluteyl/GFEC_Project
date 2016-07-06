class ChangeColumnTypesInOrders < ActiveRecord::Migration
  def change
    change_column :orders, :buyer, :integer
    change_column :orders, :seller, :integer
    rename_column :orders, :buyer, :buyer_id
    rename_column :orders, :seller, :seller_id
    add_column :orders, :location_id, :integer
    
  end
end

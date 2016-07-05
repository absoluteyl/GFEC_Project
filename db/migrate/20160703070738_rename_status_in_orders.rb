class RenameStatusInOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :status, :order_status
    change_column :orders, :order_status, :string, { :default => 'In Progress'}
  end
end

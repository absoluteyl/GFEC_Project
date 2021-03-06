class RenameStatusInCart < ActiveRecord::Migration
  def change
    rename_column :carts, :status, :cart_status
    change_column :carts, :cart_status, :string, { :default => 'New Cart' }
  end
end

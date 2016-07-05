class ModifyMerchandisePriceType < ActiveRecord::Migration
  def change
    change_column :merchandises, :price, :integer, { :null => false, :default => 0 }
  end
end

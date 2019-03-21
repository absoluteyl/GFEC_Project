class ModifyMerchandisePriceType < ActiveRecord::Migration[5.2]
  def change
    change_column :merchandises, :price, :integer, { :null => false, :default => 0 }
  end
end

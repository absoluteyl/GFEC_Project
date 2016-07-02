class ModifyMerchandiseForCart < ActiveRecord::Migration
  def change
    change_column :merchandises, :title, :string, :null => false
    change_column :merchandises, :description, :text, :null => false
    change_column :merchandises, :price, :decimal, :null => false, :default => 0
    change_column :merchandises, :amount, :integer, :null => false, :default => 1
  end
end

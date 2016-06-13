class EditMerchandiseAmountForDefaultValue1 < ActiveRecord::Migration
  def change
    change_column :merchandises, :amount, :integer, default: 1
  end
end

class EditMerchandiseAmountForDefaultValue1 < ActiveRecord::Migration[5.2]
  def change
    change_column :merchandises, :amount, :integer, default: 1
  end
end

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :buyer
      t.string :seller
      t.string :address
      t.string :status
      t.string :payment_method

      t.timestamps null: false
    end
  end
end

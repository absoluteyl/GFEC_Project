class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.string :status, null: false, default: 'new order'
      t.timestamps null: false
    end
  end
end

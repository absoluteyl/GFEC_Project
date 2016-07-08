class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.integer :postcode
      t.string :address
      t.string :recipient
      t.integer :user_id
    end
  end
end

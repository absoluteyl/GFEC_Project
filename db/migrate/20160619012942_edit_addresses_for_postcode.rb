class EditAddressesForPostcode < ActiveRecord::Migration[5.2]
  def change
    rename_column :shippings, :postcode, :postcode_id
  end
end

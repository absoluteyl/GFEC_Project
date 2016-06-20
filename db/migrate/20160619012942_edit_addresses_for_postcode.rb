class EditAddressesForPostcode < ActiveRecord::Migration
  def change
    rename_column :shippings, :postcode, :postcode_id
  end
end

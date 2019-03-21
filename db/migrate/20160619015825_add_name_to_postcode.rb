class AddNameToPostcode < ActiveRecord::Migration[5.2]
  def change
    add_column :postcodes, :name, :string
  end
end

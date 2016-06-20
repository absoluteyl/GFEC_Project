class AddNameToPostcode < ActiveRecord::Migration
  def change
    add_column :postcodes, :name, :string
  end
end

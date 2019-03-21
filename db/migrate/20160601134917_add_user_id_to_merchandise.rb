class AddUserIdToMerchandise < ActiveRecord::Migration[5.2]
  def change
    add_column :merchandises, :user_id, :integer
  end
end

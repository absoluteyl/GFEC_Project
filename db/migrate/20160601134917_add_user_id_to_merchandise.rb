class AddUserIdToMerchandise < ActiveRecord::Migration
  def change
    add_column :merchandises, :user_id, :integer
  end
end

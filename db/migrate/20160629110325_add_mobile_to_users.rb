class AddMobileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mobile, :integer
  end
end

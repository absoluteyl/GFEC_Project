class AddMobileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :integer
  end
end

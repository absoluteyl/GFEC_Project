class ChangeMobileInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :mobile, :string
  end
end

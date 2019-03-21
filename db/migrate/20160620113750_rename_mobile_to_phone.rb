class RenameMobileToPhone < ActiveRecord::Migration[5.2]
  def change
    rename_column :locations, :mobile, :phone
  end
end

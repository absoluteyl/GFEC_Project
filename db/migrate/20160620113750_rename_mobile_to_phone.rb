class RenameMobileToPhone < ActiveRecord::Migration
  def change
    rename_column :locations, :mobile, :phone
  end
end

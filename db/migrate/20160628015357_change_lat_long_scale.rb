class ChangeLatLongScale < ActiveRecord::Migration
  def change
    change_column :locations, :lat, :decimal, :precision => 15, :scale => 12
    change_column :locations, :long, :decimal, :precision => 15, :scale => 12
  end
end

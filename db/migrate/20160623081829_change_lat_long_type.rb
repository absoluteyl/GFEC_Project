class ChangeLatLongType < ActiveRecord::Migration
  def change
    change_column :locations, :lat, :decimal, :precision => 15, :scale => 13
    change_column :locations, :long, :decimal, :precision => 15, :scale => 13
  end
end

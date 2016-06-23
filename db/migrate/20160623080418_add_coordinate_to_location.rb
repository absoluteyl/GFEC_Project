class AddCoordinateToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :lat, :float
    add_column :locations, :long, :float
  end
end

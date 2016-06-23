class AddCoordinateToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :lat, :double
    add_column :locations, :long, :double
  end
end

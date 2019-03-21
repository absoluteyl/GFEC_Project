class CreateMerchandises < ActiveRecord::Migration[5.2]
  def change
    create_table :merchandises do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.integer :amount
      t.timestamps
    end
  end
end

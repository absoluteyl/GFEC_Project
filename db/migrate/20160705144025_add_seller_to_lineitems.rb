class AddSellerToLineitems < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :seller_id, :integer
  end
end

class CombineItemsInCart < ActiveRecord::Migration
  def up
    # replace multiple items for a single product in a cart with a single item 
    Cart.all.each do |cart|
      # count the number of each product in the cart
      sums = cart.line_items.group(:merchandise_id).sum(:quantity)
      
      sums.each do |merchandise_id, quantity, price|
        if quantity > 1
        # remove individual items
        cart.line_items.where(merchandise_id: merchandise_id).delete_all
        # replace with a single item
        item = cart.line_items.build(merchandise_id: merchandise_id)
        item.unit_price = Merchandise.find(merchandise_id).price
        item.quantity = quantity
        item.save!
        end
      end
    end
  end
  def down
    # split items with quantity>1 into multiple items 
    LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id,
          merchandise_id: line_item.merchandise_id, 
          unit_price: line_item.unit_price, quantity: 1
      end
      # remove original item
      line_item.destroy
    end 
  end
end

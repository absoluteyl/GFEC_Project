class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
  def add_merchandise(merchandise_id)
  current_item = line_items.find_by(merchandise_id: merchandise_id)
    if current_item
        current_item.quantity += 1
    else
        current_item = line_items.build(merchandise_id: merchandise_id)
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end

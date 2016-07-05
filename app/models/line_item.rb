class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :cart
  belongs_to :merchandise
  
  def total_price
    unit_price * quantity
  end
end

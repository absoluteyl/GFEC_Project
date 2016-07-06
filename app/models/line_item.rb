class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :cart
  belongs_to :merchandise, :class_name => 'Merchandise', :foreign_key => 'merchandise_id'
  belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
  
  def total_price
    unit_price * quantity
  end
end

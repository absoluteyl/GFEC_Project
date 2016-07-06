class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :cart
  belongs_to :merchandise
  belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
  
  def total_price
    unit_price * quantity
  end
end

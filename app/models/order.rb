class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :buyer, :class_name => 'User', :foreign_key => "buyer_id"
  belongs_to :seller, :class_name => 'User', :foreign_key => "seller_id"
  
  PAYMENT_METHODS = [ "面交", "宅配（使用歐付寶付款）" ]
  
  validates :payment_method, inclusion: PAYMENT_METHODS
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end

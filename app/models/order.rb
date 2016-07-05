class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :merchandises, through: :line_items
  
  #PAYMENT_METHODS = [ "面交", "宅配（使用歐付寶付款）" ]
end

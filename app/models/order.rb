class Order < ActiveRecord::Base
  has_many :line_items
  has_many :merchandises, through: :line_items
end

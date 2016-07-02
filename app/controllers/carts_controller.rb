class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show]
  def show
    
  end
  
  
end
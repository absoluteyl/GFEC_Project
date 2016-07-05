class OrdersController < ApplicationController
  def new
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end
    @order = Order.new
  end
  
  private
  def order_params
    params.require(:order).permit(:id, )
  end
end
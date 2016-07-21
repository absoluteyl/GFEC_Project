class OrdersController < ApplicationController
  
  def show
    @orders = Order.where(buyer_id: current_user.id)
  end
  
  def new
    if @cart.line_items.empty?
      redirect_to merchandises_path, notice: "Your cart is empty"
      return
    end
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.order_status = "New Order"
    @order.buyer = current_user
    @order.seller = @cart.line_items.last.merchandise.user
    

    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      
      redirect_to merchandises_path, notice: 'Thank you for your purchase.'
    else
      render 'new'
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:buyer, :payment_method, :location_id )
  end
end
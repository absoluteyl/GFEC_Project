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
    @order.total = @cart.total_price

    if @order.save
      if @order.payment_method == "面交"
        redirect_to merchandises_path, notice: 'Thank you for your purchase.'
      else
        redirect_to new_payment_path
      end
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
    else
      render 'new'
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:buyer, :payment_method, :location_id )
  end
end
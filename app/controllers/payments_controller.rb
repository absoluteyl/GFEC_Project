class PaymentsController < ApplicationController
  before_action :set_amount, only: [:new, :create]
  def new
  end
  
  def create
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount*100,
      :description => 'Rails Stripe customer',
      :currency    => 'twd'
    )
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
  
  private
  def set_amount
    @order = Order.where(buyer_id: current_user.id).last
     # Amount in cents
    @amount = @order.total
  end
end

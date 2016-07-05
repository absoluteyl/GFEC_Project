class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  def show
    
  end
  
  def destroy
    @cart.destroy
    if @cart.id == session[:cart_id]
      session[:cart_id] = nil
      redirect_to merchandises_url, notice: 'Your cart is currently empty'
      # respond_to do |format|
      #   format.html { redirect_to store_url, notice: 'Your cart is currently empty' }
      #   format.json { head :no_content }
      # end
    end
  end
  
  private
  def set_cart
    @cart = Cart.find(params[:id])
  end
  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}" 
    redirect_to merchandises_url, notice: 'Invalid Cart'
  end
end
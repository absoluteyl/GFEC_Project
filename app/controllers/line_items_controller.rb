class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :destroy]
  before_action :set_merchandise, only: [:create]
  before_action :set_line_item, only: [:update, :destroy]
  
  def create
    if @cart.line_items.any?
      redirect_to cart_path(@cart), notice: 'You need to checkout or remove existing items first' 
    else
      @line_item = @cart.add_merchandise(@merchandise.id)
      @line_item.unit_price = @merchandise.price
      if @line_item.save
        flash[:success] = "Merchandise is been added to cart successfully."
        redirect_to @line_item.cart
      else
        render 'new'
      end
    end
    
    
    # respond_to do |format| 
    #   if @line_item.save
    #     format.html { redirect_to @line_item.cart, notice: 'Line item was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @line_item }
    #   else
    #     format.html { render action: 'new' } 
    #     format.json { render json: @line_item.errors, status: :unprocessable_entity }
    #   end
    # end
  end
  
  def update
    
  end
  
  def destroy
    @line_item.destroy
    flash[:danger] = "Item was removed from cart successfully."
    redirect_to merchandises_path
  end
  
  
  private
  def set_merchandise
    @merchandise = Merchandise.find(params[:merchandise_id])
  end
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
  
  def line_item_params
    params.require(:line_item).permit(:merchandise_id) 
  end
  
end
class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  
  def index
    
  end
  def show
    
  end
  def new
    
  end
  def create
    merchandise = Merchandise.find(params[:merchandise_id])
    @line_item = @cart.line_items.build(merchandise: merchandise)
    @line_item.unit_price = merchandise.price
    if @line_item.save
      flash[:success] = "Merchandise is been added to cart successfully."
      redirect_to @line_item.cart
    else
      render 'new'
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
  def edit
    
  end
  def update
    
  end
  def destroy
    
  end
  
  
  private
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
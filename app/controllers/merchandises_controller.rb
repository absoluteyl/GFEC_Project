class MerchandisesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_merchandise, only: [:edit, :update, :show, :destroy]
    before_action :set_category, only: [:new, :create, :edit]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
       @merchandise = Merchandise.new 
    end
    def create
      @merchandise = Merchandise.new(merchandise_params)
      @merchandise.user = current_user
      if @merchandise.save
        flash[:success] = "Your merchandise was successfully uploaded"
        redirect_to merchandise_path(@merchandise)
      else
        render 'new'
        #"render :new"  does the same thing
      end
    end
    
    def show

    end
    def index
      @merchandise = Merchandise.all
    end
    
    def edit
      
    end
    def update
        if @merchandise.update(merchandise_params)
          flash[:success] = "You merchandise was successfully updated"
          redirect_to merchandise_path(@merchandise)
        else
          render 'edit'
        end 
    end
    
    def destroy
      @merchandise.destroy
      flash[:danger] = "Merchandise was successfully deleted"
      redirect_to merchandises_path
    end
    
    def update_subcategories
        @subcategories = Category.where(parent_id: params[:parent_id])
        respond_to do |format|
          format.js
        end
    end
    
    private
    def merchandise_params
        params.require(:merchandise).permit(:title, :description, :price, :category_id, :location_id, :image_1, :image_2, :image_3)
    end
    
    def set_merchandise
      @merchandise = Merchandise.find(params[:id])
    end
    
    def set_category
        @categories = Category.where(parent_id: nil)
        @subcategories = Category.where(parent_id: Category.where(parent_id: nil).first.id) 
    end
    
    def require_same_user
      if current_user != @merchandise.user and !current_user.admin?
        flash[:danger] = "You can only edit or delete your own merchandise."
        redirect_to root_path
      end
    end
end

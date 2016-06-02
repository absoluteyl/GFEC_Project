class MerchandisesController < ApplicationController
    before_action :set_merchandise, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
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
      @merchandise = Merchandise.find(params[:id])
    end
    def index
      @merchandise = Merchandise.all
    end
    
    def edit
        @merchandise = Merchandise.find(params[:id])
    end
    def update
        if @merchandise.update(merchandise_params)
          flash[:success] = "You merchandise was successfully updated"
          redirect_to article_path(@merchandise)
        else
          render 'edit'
        end 
    end
    
    def destroy
      @merchandise = Merchandise.find(params[:id])
      @merchandise.destroy
      flash[:danger] = "Merchandise was successfully deleted"
      redirect_to merchandises_path
    end
    
    
    private
    def merchandise_params
        params.require(:merchandise).permit(:title, :description, :price, :amount)
    end
    def set_merchandise
      @merchandise = Merchandise.find(params[:id])
    end
    def require_same_user
      if current_user != @merchandise.user and !current_user.admin?
        flash[:danger] = "You can only edit or delete your own merchandise."
        redirect_to root_path
      end
    end

end

class MerchandisesController < ApplicationController
    def new
       @merchandise = Merchandise.new 
    end
    def create
        @merchandise = Merchandise.new(merchandise_params)
        @merchandise.user = User.first #hard code user id temporary
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
end

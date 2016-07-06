class LocationsController < ApplicationController
    before_action :set_location, only: [:edit, :update, :destroy]
    
    def index
        @locations = Location.where(user_id: current_user.id)
    end
    
    def new
        @location = Location.new
    end
    def create
        @location = Location.new(location_params)
        @location.user = current_user
        if @location.save
            flash[:success] = "Your location was been added successfully"
            redirect_to locations_path
        else
            render 'new'
            #"render :new"  does the same thing
        end
    end
    
    def edit
      
    end
    def update
        if @location.update(location_params)
          flash[:success] = "You location was successfully updated"
          redirect_to locations_path
        else
          render 'edit'
        end 
    end
    
    def destroy
      @location.destroy
      flash[:danger] = "Location was successfully deleted"
      redirect_to locations_path
    end
    
    private
    def set_location
        @location = Location.find(params[:id])
        puts @location.id
    end
    def location_params
        params.require(:location).permit(:city_id, :address, :recipient, :phone, :lat, :long)
    end
end
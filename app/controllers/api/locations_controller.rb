class Api::LocationsController < Api::ApiController
  skip_before_filter :verify_authenticity_token
  before_action :set_location, only: [:edit, :update, :destroy]
  def index
    @locations = Location.all
    if id = params[:id]
      @locations = @locations.where(id: id)
    end
    if city_id = params[:city_id]
        @locations = @locations.where(city_id: city_id)
    end
      render status: 200, json: {
        status: "OK", 
        locations: @locations,
        merchandises: query_merchandises(@locations)
      }.to_json
  end
  # def show
  #   if user = params[:user]
  #     @locations = Location.where(user: user)
  #     render status: 200, json: {
  #       status: "OK", 
  #       locations: @locations.as_json
  #     }.to_json
  #   else
  #     render status: 422, json: {
  #       status: "Unprocessable Entity",
  #       message: "Must define user"
  #     }.to_json
  #   end
    
  # end
  
  def create
    @location = Location.new(location_params)
    if @location.save
      render status: 200, json: {
          status: "OK",
          message: "Location is been successfully created.",
          location: @location.as_json
      }.to_json
    else
      render status: 422, json: {
        status: "Unprocessable Entity",
        message: "Location cannot be created.",
        errors: @location.errors
      }.to_json
    end
  end
  
  def update
    if @location.update(location_params)
      render status: 200, json: {
        status: "OK",
        message: "Location is been updated.",
        location: @location.as_json
      }.to_json
    else
      render status: 422, json: {
            status: "Unprocessable Entity",
            message: "Location cannot be udpated.",
            errors: @location.errors
      }.to_json
    end 
  end
  
  def destroy
    @location.destroy
    render status: 200, json: {
        status: "OK",
        message: "Location is been deleted successfully."
    }.to_json
  end
  
  private
  def set_location
      @location = Location.find(params[:id])
      puts @location.id
  end
  def location_params
      params.require(:location).permit(:city_id, :address, :recipient, :phone, :user_id, :lat, :long)
  end
  def query_merchandises(locations)
    
    mer_list = []
    locations.each do |location|
      mer_list.push(Merchandise.where(location: location).order(:updated_at).reverse_order)
    end
    mer_list.map{|i| i.take(3)}
  end
  
end
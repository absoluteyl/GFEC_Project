class Api::CitiesController < Api::ApiController
  def index
    @cities = City.all
    if name = params[:name]
        @cities = @cities.where(name: name)
    end
    if id = params[:id]
      @cities = @cities.where(id: id)
    end
    
    render status: 200, json: {
    status: "OK", 
    categories: @cities
    }.to_json
  end
end
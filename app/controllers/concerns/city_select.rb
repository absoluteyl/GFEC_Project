module CitySelect
  extend ActiveSupport::Concern
  
  private
  
  def update_districts
    @districts = City.where(parent_id: params[:parent_id])
    respond_to do |format|
      format.js
    end
  end
end
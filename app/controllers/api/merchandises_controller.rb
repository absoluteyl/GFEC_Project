class Api::MerchandisesController < Api::ApiController
  before_action :set_merchandise, only: [:edit, :update, :show, :destroy]

  def index
    @merchandises = Merchandise.where(amount: 1)
    if title = params[:title]
      @merchandises = @merchandises.where(title: title)
    elsif price = params[:price]
      @merchandises = @merchandises.where(price: price)
    elsif category_id = params[:category_id]
      @merchandises = @merchandises.where(category_id: category_id)
    end
    render status: 200, json: {
        status: "OK",
        merchandises: @merchandises.as_json
    }.to_json
  end

  def show
      render status: 200, json: {
          status: "OK",
          merchandise: @merchandise.as_json
      }.to_json
  end

  def create
    @merchandise = Merchandise.new(merchandise_params)
    if @merchandise.save
        render status: 200, json: {
            status: "OK",
            message: "Merchandise is been successfully created.",
            merchandise: @merchandise.as_json
        }.to_json
    else
        render status: 422, json: {
            status: "Unprocessable Entity",
            message: "Merchandise cannot be created.",
            errors: @merchandise.errors
        }.to_json
    end
  end

  def update
    if @merchandise.update(merchandise_params)
        render status: 200, json: {
            status: "OK",
            message: "Merchandise is been updated.",
            merchandise: @merchandise.as_json
        }.to_json
    else
        render status: 422, json: {
            status: "Unprocessable Entity",
            message: "Merchandise cannot be udpated.",
            errors: @merchandise.errors
        }.to_json
    end
  end

  def destroy
    @merchandise.destroy
    render status: 200, json: {
        status: "OK",
        message: "Merchandise is been deleted successfully."
    }.to_json
  end

  private
  def merchandise_params
    #need to add category_id after ready
    params.require(:merchandise).permit(:title, :description, :price, :amount, :user_id, :category_id, :location_id, :image_1, :image_2, :image_3)
  end

  def set_merchandise
    @merchandise = Merchandise.find(params[:id])
  end
end

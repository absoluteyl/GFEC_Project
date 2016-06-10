module Api
   class MerchandisesController < ApplicationController
      #Temporary disable CSRF
      skip_before_filter :verify_authenticity_token
      
      before_action :set_merchandise, only: [:edit, :update, :show, :destroy]
      
      def index
        @merchandises = Merchandise.all
        if title = params[:title]
            @merchandises = @merchandises.where(title: title)
        end
        if price = params[:price]
            @merchandises = @merchandises.where(price: price)
        end
        render json: {
            status: 200, 
            merchandises: @merchandises
        }.to_json
      end
      
      def show
          render json: {
              status: 200,
              merchandise: @merchandise
          }.to_json
      end
      
      def create
        @merchandise = Merchandise.new(merchandise_params)
        if @merchandise.save
            render json: {
                status: 200,
                message: "Merchandise is been successfully created.",
                merchandise: @merchandise
            }.to_json
        else
            render json: {
                status: 500,
                message: "Merchandise cannot be created.",
                errors: @merchandise.errors
            }.to_json
        end
      end
      
      def update
        if @merchandise.update(merchandise_params)
            render json: {
                status: 200,
                message: "Merchandise is been updated.",
                merchandise: @merchandise
            }.to_json
        else
            render json: {
                status: 500,
                message: "Merchandise cannot be udpated.",
                errors: @merchandise.errors
            }.to_json
        end
      end
      
      def destroy
        @merchandise.destroy
        render json: {
            status: 200,
            message: "Merchandise is been deleted successfully."
        }.to_json
      end
      
      private
      def merchandise_params
        #need to add category_id after ready
        params.require(:merchandise).permit(:title, :description, :price, :amount, :user_id)
      end
      
      def set_merchandise
        @merchandise = Merchandise.find(params[:id])
      end
   end
end
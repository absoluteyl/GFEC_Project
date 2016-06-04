module Api
   class MerchandisesController < ApplicationController
      def index
        @merchandises = Merchandise.all
        if title = params[:title]
            @merchandises = @merchandises.where(title: title)
        end
        if price = params[:price]
            @merchandises = @merchandises.where(price: price)
        end
        render json: @merchandises, status: 200
      end
      
      def show
          @merchandise = Merchandise.find(params[:id])
          render json: @merchandise, status: 200
      end
   end
end
module Api
   class MerchandisesController < ApplicationController
      def index
        @merchandises = Merchandise.all
        if price = params[:price]
            @merchandises = @merchandises.where(price: price)
        end
        render json: @merchandises, status: 200
      end
   end
end
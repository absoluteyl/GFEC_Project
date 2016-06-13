module Api
   class CategoriesController < ApplicationController
      def index
        @categories = Category.all
        if name = params[:name]
            @categories = @categories.where(name: name)
        end
        render json: @categories, status: 200
      end
      
      def show
          @category = Category.find(params[:id])
          render json: @category, status: 200
      end
   end
end
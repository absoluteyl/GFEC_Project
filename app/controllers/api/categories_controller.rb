module Api
   class CategoriesController < ApplicationController
      def index
        @categories = Category.all
        if name = params[:name]
            @categories = @categories.where(name: name)
        end
        if id = params[:id]
          @categories = @categories.where(id: id)
        end
        
        render status: 200, json: {
        status: "OK", 
        categories: @categories
    }.to_json
      end
   end
end
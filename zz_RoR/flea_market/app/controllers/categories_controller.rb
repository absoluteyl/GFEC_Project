class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    
    def index
        # Display all the parent categories
        @categories = Category.where(:parent_id => nil)

    end
    
    # def show
        
    # end
    # Show subcategory
    def show
      # Find the category belonging to the given id
      @category = Category.find(params[:id])
      # Grab all sub-categories
      @categories = @category.subcategories
      # We want to reuse the index renderer:
      render :action => :index
    end
    
    def new
        @category = Category.new
        @category.parent = Category.find(params[:id]) unless params[:id].nil?
    end
    def create
        @category = Category.new(category_params)
        if @category.save
          flash[:success] = "Category was created successfully"
          redirect_to categories_path
        else
          render 'new'
        end
    end
    
    private
    def category_params
        params.require(:category).permit(:name, :parent_id)
    end
    def require_admin
      if !logged_in? || (logged_in? && !current_user.admin?)
        flash[:danger] = "Only admins can perform that action"
        redirect_to categories_path
      end
    end
end
module Api
   class UsersController < ApplicationController
      def index
        @users = User.all
        if username = params[:username]
            @users = @users.where(username: username)
        end
        
        render json: @users, status: 200
      end
      
      def show
          @user = User.find(params[:id])
          render json: @user, status: 200
      end
      
    #   private
    #     def safe_params
    #       params.require(:user).permit(:username, :email, :phone) 
    #     end
   end
end
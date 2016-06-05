class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]


    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
      flash[:success] = "Welcome to the Flea Market, #{@user.username}"
      redirect_to user_path(@user)

        else
            render 'new'
        end
    end
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Your account is updated successfully"
            redirect_to merchandises_path
        else
            render 'edit'
        end
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def index
        @users = User.all
    end
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "User and all merchandise created by this user have been deleted"
        redirect_to users_path
    end

    private
        def user_params
            params.require(:user).permit(:username, :email, :mobile, :password)
        end

        def set_user
            @user = User.find(params[:id])
        end
        def require_same_user
            if current_user != @user and !current_user.admin?
              flash[:danger] = "You can only edit your own account"
              redirect_to root_path
            end
        end
        
        def require_admin
            if logged_in? and !current_user.admin? 
              flash[:danger] = "Only admin users can perform this action"
              redirect_to root_path
            end
        end

end
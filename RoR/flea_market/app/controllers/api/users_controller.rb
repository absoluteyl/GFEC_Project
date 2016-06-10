class Api::UsersController < Api::ApiController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  
  def index
    @users = User.all
    if username = params[:username]
        @users = @users.where(username: username)
    end
    if email = params[:email]
        @users = @users.where(email: email)
    end
    render status: 200, json: {
        status: "OK", 
        users: @users.as_json
    }.to_json
  end
  
  def show
      render status: 200, json: {
          status: "OK", 
          user: @user.as_json
      }.to_json
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
        render status: 200, json: {
            status: "OK",
            message: "User is been successfully created.",
            user: @user.as_json
        }.to_json
    else
        render status: 422, json: {
            status: "Unprocessable Entity",
            message: "User cannot be created.",
            errors: @user.errors
        }.to_json
    end
  end
  
  def update
    if @user.update(user_params)
        render status: 200, json: {
            status: "OK",
            message: "User is been updated.",
            user: @user.as_json
        }.to_json
    else
        render status: 422, json: {
            status: "Unprocessable Entity",
            message: "User cannot be udpated.",
            errors: @user.errors
        }.to_json
    end
  end
  
  def destroy
    @user.destroy
    render status: 200, json: {
        status: "OK",
        message: "User is been deleted successfully."
    }.to_json
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :phone, :password) 
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
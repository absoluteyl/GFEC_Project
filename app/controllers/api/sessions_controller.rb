class Api::SessionsController < Api::ApiController
  skip_before_action :authenticate_user!
  before_action :ensure_params_exist
  respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:user_login][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token
      render status: 200, json: {
        status: "OK",
        message: "You're successfully signed in.",
        "id": resource.id,
        "username": resource.username,
        "email": resource.email,
        "authentication_token": resource.authentication_token,
        "avatar": resource.avatar.url(:small)
      }.to_json
      return
    end
    invalid_login_attempt
  end

  def destroy
    resource = User.find_for_database_authentication(:email => params[:user_login][:email])
    resource.authentication_token = nil
    resource.save
    render status: 200, json: {
      status: "OK",
      message: "You're successfully signed out."
    }.to_json
  end

  protected
  def ensure_params_exist
    return unless params[:user_login].blank?
    render status: 422, json: {
      status: "Unprocessable Entity",
      message: "Missing user_login parameter"
    }.to_json
  end

  def invalid_login_attempt
    render status: 401, json: {
      status: "Unauthorized",
      message: "Error with your login or password"
    }
  end
end

module Api
  class ApiController < ApplicationController
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session
    #Diable CSRF temporary
    skip_before_filter :verify_authenticity_token
    skip_before_filter :authenticate_user!
    before_filter :restrict_access
    respond_to :json
    private
    def restrict_access
      api_key = ApiKey.find_by_api_key(params[:api_key])
      head :unauthorized unless api_key
  	end
  end
end
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_error

  helper_method :current_user, :logged_in?
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id]) 
    elsif cookies.permanent.signed[:remember_me_token]
      verification = Rails.application.message_verifier(:remember_me).verify(cookies.permanent.signed[:remember_me_token])
      if verification
        Rails.logger.info "Logging in by cookie."
        @current_user ||= User.find(verification)
      end
    end
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to root_path
    end
  end
  
  private
  def render_404
    respond_to do |format|
      format.html do
        render file: 'public/404.html', status: :not_found, layout: false
      end
      format.json do
        render status: 404, json: {
          message: "Not Found."
        }
      end
    end
  end
end

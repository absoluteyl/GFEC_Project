class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_error

  # private
  # def render_404
  #   respond_to do |format|
  #     format.html do
  #       render file: 'public/404.html', status: :not_found, layout: false
  #     end
  #     format.json do
  #       render status: 404, json: {
  #         message: "Not Found."
  #       }
  #     end
  #   end
  # end
end

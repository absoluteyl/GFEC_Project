module Api
	class ApiController < ApplicationController
		#Diable CSRF temporary
  		skip_before_filter :verify_authenticity_token
		# Prevent CSRF attacks by raising an exception.
  		# For APIs, you may want to use :null_session instead.
  		protect_from_forgery with: :null_session
  		#before_filter :authenticate
		
		def current_user
			@current_user
		end

  	# 	def authenticate
  	# 		authenticate_or_request_with_http_basic do |username, password|
  	# 			Rails.logger.info "API authentication:#{username} #{password}"
  	# 			user = User.find_by(username: username)
  	# 			if user && user.authenticate(password)
  	# 				@current_user = user
  	# 				Rails.logger.info "Logging in #{user.inspect}"
  	# 				true
  	# 			else
  	# 				Rails.logger.warn "No valid credentials."
  	# 				false
  	# 			end
			# end
  	# 	end
	end
end
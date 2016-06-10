module Api
   class ApiController < ApplicationController
        #Temporary disable CSRF
        skip_before_filter :verify_authenticity_token
  
   end
end
require 'test_helper'

class ListingUsersApiTest < ActionDispatch::IntegrationTest

    test 'return list of all users' do
        get '/api/users?api_key=4484c065f013c7ff144f5c618fa8f341'
        assert response.success?
        refute_empty response.body
    end
    
    test 'returns users filtered by username' do
      @user = User.create(username: "john", email: "john@example.com", mobile:"0987654321", password: "password")
      @user2 = User.create(username: "mary", email: "mary@example.com", mobile:"0987654123", password: "password")
      get '/api/users?api_key=4484c065f013c7ff144f5c618fa8f341&username=john'
      assert_equal 200, response.status
      
      http_response = json(response.body)
      users = http_response[:users]
      username = users.collect{ |m| m[:username]}
      assert_includes username, "john"
      refute_includes username, "mary"
    end
    
    test 'returns user by id' do
      @user = User.create(username: "john", email: "john@example.com", mobile:"0987654321", password: "password")
      get "/api/users/#{@user.id}?api_key=4484c065f013c7ff144f5c618fa8f341"
      assert_equal 200, response.status
       
      http_response = json(response.body)
      # puts http_response
      user_response = http_response[:user]
      # puts user_response[:username]
      assert_equal @user.username, user_response[:username]
    end
end
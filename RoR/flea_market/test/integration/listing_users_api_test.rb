require 'test_helper'

class ListingUsersApiTest < ActionDispatch::IntegrationTest

    test 'return list of all users' do
        get '/api/users'
        assert response.success?
        refute_empty response.body
    end
    
    test 'returns users filtered by username' do
      @user = User.create(username: "john", email: "john@example.com", mobile:"0987654321", password: "password")
      @user2 = User.create(username: "mary", email: "mary@example.com", mobile:"0987654123", password: "password")
      get '/api/users?username=john'
      assert_equal 200, response.status
        
      users = json(response.body)
      username = users.collect{ |m| m[:username]}
      assert_includes username, "john"
      refute_includes username, "mary"
    end
    
    test 'returns user by id' do
      @user = User.create(username: "john", email: "john@example.com", mobile:"0987654321", password: "password")
      get "/api/users/#{@user.id}"
      assert_equal 200, response.status
       
      user_response = json(response.body)
      assert_equal @user.username, user_response[:username]
    end
end
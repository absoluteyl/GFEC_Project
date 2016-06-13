require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @user = User.create(username: "john", email: "john@example.com",mobile: "0987654321", password: "password", admin: true)
    @category = Category.create(name: "sports")
    @subcategory = Category.create(name: "golf", parent_id: 1)
  end

  test "should get categories index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test "should get show for category" do
    get( :show, {'id' => @category.id })
    assert_response :success
  end
    test "should get show for subcategory" do
    get( :show, {'id' => @subcategory.id })
    assert_response :success
  end
  
  test "should redirect create when admin not login" do
    assert_no_difference 'Category.count' do
        post :create, category: { name: "sports" }
    end
    assert_redirected_to categories_path
  end
end
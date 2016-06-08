require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@example.com", mobile: "0987654321", password: "password", admin: true)
  end
  
  test "Get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_path                    
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do          
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end
  
  test "Get new category form and create subcategory" do
    sign_in_as(@user, "password")
    get new_category_path                    
    assert_template 'categories/new'
    assert_difference 'Category.count', 2 do
      post_via_redirect categories_path, category: {name: "sports"}
      post_via_redirect categories_path, category: {name: "golf", parent_id: 1}
    end
    assert_template 'categories/index'
    assert_match "golf", response.body
  end
  
  test "Invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
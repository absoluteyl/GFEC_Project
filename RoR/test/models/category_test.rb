require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup 
    @category = Category.new(name: "sports")
    @subcategory = Category.new(name: "golf", parent_id: 1)
  end

  test "category should be valid" do
    assert @category.valid?
  end
  test "subcategory should be valid" do
    assert @subcategory.valid?
  end
  
  # test "subcategory should no be created if parent_id not exist" do
  #   subcategory2 = Category.new(name: "basketball", parent_id: 2)
  #   assert_not subcategory2.valid?
  # end
  
  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end
  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end
  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
  

end
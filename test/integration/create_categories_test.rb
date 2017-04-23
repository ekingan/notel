require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "Kingan", email: "kingan@gmail.com", password: "password", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user, "password")
    #go to new category path
    get new_category_path
    #get new form
    assert_template 'categories/new'
    #post to new form to create new category
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    #redirects you to index page
    assert_template 'categories/index'
    #index page should have "sports" displayed on page
    assert_match "sports", response.body
  end

  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    #got to new category path
    get new_category_path
    #get new form
    assert_template 'categories/new'
    #post to new form to create new category
    assert_no_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: " "}
    end
    #redirects you to index page
    assert_template 'categories/new'
    #errors show up in below classes
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end

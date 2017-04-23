require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest

  test "get signup form and create new user" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "Kingan", email: "kingan@gmail.com", password: "password"}
    end
    assert_template 'users/show'
  end
end

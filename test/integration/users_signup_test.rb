require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup infromation" do
    get signup_path
    
    assert_no_difference 'User.count' do
      post users_path, user: { name: '', emails: 'blah@blah.com', 
                               password: '12345', password_confirmation: '123' }
    end
    
    assert_template 'users/new'
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end

  test "valid signup information" do
    get signup_path

    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Example User", 
                                            email: "user@example.com",
                                            password: "password", 
                                            password_confirmation: "password" }
    end
    
    assert_template 'users/show'
    assert_not flash.nil?
    assert is_logged_in?
    end
end

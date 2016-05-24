require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :jack
  end

  test "Unsuccessful edit" do
    # need this after authorization addition in CH.9.
    log_in_as @user

    get edit_user_path @user
    assert_template 'users/edit'

    patch user_path(@user), user: { name: "", 
                                    email: "foo@wrong", 
                                    password: "pass", 
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  test "Successful edit" do
    # need this after authorization addition in CH.9.
    log_in_as @user

    get edit_user_path @user
    assert_template 'users/edit'

    name = "Foo Bar"
    email = "sam@twitter.com"

    patch user_path(@user), user: { name: name, email: email, password: "", password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path @user
    log_in_as @user
    assert_redirected_to edit_user_path @user
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name: name,
      email: email,
      password: "foobar",
      password_confirmation: "foobar" }
      assert_not flash.empty?
      assert_redirected_to @user
      @user.reload
      assert_equal @user.name, name
      assert_equal @user.email, email
    end
end

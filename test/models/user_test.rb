require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new name: 'Jon Doe', email: 'jon@doe.com', 
                     password: 'password', password_confirmation: 'password'
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name shoud be present' do
    @user.name = '   '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '   '
    assert_not @user.valid?
  end

  test 'name should not be too long nor too short' do
    @user.name = 'a' * 51
    assert_not @user.valid?
    @user.name = 'aa'
    assert_not @user.valid?    
  end

  test 'email should be within string size limit and not too short' do
    @user.email = 'a' * 256
    assert_not @user.valid?
    @user.email = 'a' * 7
    assert_not @user.valid?
  end

  test 'valid emails should be accepted' do
    valid_addresses = %w[user@example.com 
                         USER@foo.COM 
                         A_US-ER@foo.bar.org 
                         first.last@foo.jp 
                         alice+bob@baz.cn]
    
    valid_addresses.each do |addr|
      @user.email = addr
      assert @user.valid?, "#{addr.inspect} should be valid."
    end
  end

  test 'invalid emails should be rejected' do
    invalid_addresses = %w[user@example,com 
                          user_at_foo.org 
                          user.name@example.
                          foo@bar_baz.com 
                          foo@bar+baz.com]
    
    invalid_addresses.each do |addr|
      @user.email = addr
      assert_not @user.valid?, "#{addr.inspect} should be valid."
    end
  end

  test 'emails should be unique' do
    duplicate = @user.dup
    @user.save
    assert_not duplicate.valid?
  end

  test 'password should not be too short' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid? 
  end
end

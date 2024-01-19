require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      username: 'test-user',
      email: 'fake@email.com',
      password: 'test-password'
    )
  end

  test 'User should be valid' do
    assert @user.valid?
  end

  test 'username should be present' do
    @user.username = ''
    assert_not @user.valid?
  end

  test 'username should be unique' do
    @user.save
    @user2 = User.new(username: 'test-user', email: 'fake2@email.com')
    assert_not @user2.valid?
  end

  test 'username should not be too long' do
    @user.username = 'a'
    assert_not @user.valid?
  end

  test 'username should not be too short' do
    @user.username = 'this sentence is too long to be valid'
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'email should be unique' do
    @user.save
    @user2 = User.new(username: 'test-user-2', email: 'fake@email.com')
    assert_not @user2.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a'
    assert_not @user.valid?
  end

  test 'email should not be too short' do
    @user.email = ('a' * 100) + '@email.com'
    assert_not @user.valid?
  end

  test 'email should have the correct format' do
    @user.email = 'wrong format for email'
    assert_not @user.valid?
  end
end

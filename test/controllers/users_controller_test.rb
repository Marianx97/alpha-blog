require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(
      username: 'test-username',
      email: 'fake@email.com',
      password: 'test-password'
    )
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get '/signup'
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count', 1) do
      post users_url, params: {
        user: {
          username: 'test-username-2',
          email: 'fake_2@email.com',
          password: 'test-password-2'
        }
      }
    end
    assert_redirected_to articles_url
  end

  test 'should show user' do
    sign_in_as(@user)
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    sign_in_as(@user)
    patch user_url(@user), params: {
      user: {
        username: 'test-username-edit'
      }
    }
    assert_redirected_to user_url(@user)
  end

  test 'should destroy user' do
    sign_in_as(@user)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    assert_redirected_to root_path
  end
end

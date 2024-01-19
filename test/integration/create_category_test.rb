require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @admin = User.create(
      username: 'admin',
      email: 'email_fake@email.com',
      password: 'admin-password',
      admin: true
    )
  end

  test 'Get the new category form and create the category' do
    sign_in_as(@admin)
    get '/categories/new'
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: 'Sports' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Sports', response.body
  end

  test 'Get the new category form and reject invalid category submission' do
    sign_in_as(@admin)
    get '/categories/new'
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: '' } }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(
      username: 'test-username',
      email: 'fake@email.com',
      password: 'test-password'
    )
    @article = Article.create(
      title: 'Awesome Title',
      description: 'Article description',
      user: @user
    )
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get new' do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    sign_in_as(@user)
    assert_difference('Article.count', 1) do
      post articles_url, params: {
        article: {
          title: 'Awesome Title 2',
          description: 'Description of the article',
          user_id: @user.id
        }
      }
    end
    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    get article_url(@article)
    assert_response :success
  end

  test 'should get edit' do
    sign_in_as(@user)
    get edit_article_url(@article)
    assert_response :success
  end

  test 'should update article' do
    sign_in_as(@user)
    patch article_url(@article), params: {
      article: {
        description: 'Edit - Description of the article'
      }
    }
    assert_redirected_to article_url(@article)
  end

  test 'should destroy article' do
    sign_in_as(@user)
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
    assert_redirected_to articles_url
  end
end

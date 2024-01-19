require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @user = User.create(
      username: 'test-user',
      email: 'fake@email.com',
      password: 'test-password'
    )
    @article = Article.new(
      title: 'Test article',
      description: 'Test article description',
      user: @user
    )
  end

  test 'Article should be valid' do
    assert @article.valid?
  end

  test 'Title should be present' do
    @article.title = ''
    assert_not @article.valid?
  end

  test 'Title should not be too long' do
    @article.title = 'a' * 150
    assert_not @article.valid?
  end

  test 'Title should not bee too short' do
    @article.title = 'a'
    assert_not @article.valid?
  end

  test 'Description should be present' do
    @article.description = ''
    assert_not @article.valid?
  end

  test 'Description should not be too long' do
    @article.description = 'a' * 350
    assert_not @article.valid?
  end

  test 'Description should not bee too short' do
    @article.description = 'a'
    assert_not @article.valid?
  end

  test 'Article should belong to user' do
    @article.user = nil
    assert_not @article.valid?
  end
end

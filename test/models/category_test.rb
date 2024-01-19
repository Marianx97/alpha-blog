require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: 'Sports')
  end

  test 'Category should be valid' do
    assert @category.valid?
  end

  test 'Name should be present' do
    @category.name = ''
    assert_not @category.valid?
  end

  test 'Name should be unique' do
    @category.save
    @category2 = Category.new(name: 'Sports')
    assert_not @category2.valid?
  end

  test 'Name should not be too long' do
    @category.name = 'a'
    assert_not @category.valid?
  end

  test 'Name should not be too short' do
    @category.name = 'this sentence is too long to be valid'
    assert_not @category.valid?
  end
end

require 'test_helper'

class ProductCategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ProductCategory.new.valid?
  end
end

require 'test_helper'

class CardCategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CardCategory.new.valid?
  end
end

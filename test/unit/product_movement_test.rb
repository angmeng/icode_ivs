require 'test_helper'

class ProductMovementTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ProductMovement.new.valid?
  end
end

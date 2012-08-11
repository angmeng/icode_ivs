require 'test_helper'

class StockAdjustmentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert StockAdjustment.new.valid?
  end
end

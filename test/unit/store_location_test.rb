require 'test_helper'

class StoreLocationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert StoreLocation.new.valid?
  end
end

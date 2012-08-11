require 'test_helper'

class PaymentMethodTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PaymentMethod.new.valid?
  end
end

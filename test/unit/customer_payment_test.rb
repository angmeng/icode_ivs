require 'test_helper'

class CustomerPaymentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CustomerPayment.new.valid?
  end
end

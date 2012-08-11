require 'test_helper'

class SupplierPaymentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert SupplierPayment.new.valid?
  end
end

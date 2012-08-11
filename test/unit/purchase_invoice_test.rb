require 'test_helper'

class PurchaseInvoiceTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PurchaseInvoice.new.valid?
  end
end

require 'test_helper'

class PurchaseInvoiceItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PurchaseInvoiceItem.new.valid?
  end
end

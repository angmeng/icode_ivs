require 'test_helper'

class InvoiceItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert InvoiceItem.new.valid?
  end
end

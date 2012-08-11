require 'test_helper'

class ChequeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Cheque.new.valid?
  end
end

require 'test_helper'

class BankTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Bank.new.valid?
  end
end

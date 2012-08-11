require 'test_helper'

class DocumentStorageTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert DocumentStorage.new.valid?
  end
end

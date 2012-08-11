require 'test_helper'

class DocumentCategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert DocumentCategory.new.valid?
  end
end

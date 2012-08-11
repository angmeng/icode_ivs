require 'test_helper'

class StockAdjustmentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => StockAdjustment.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    StockAdjustment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    StockAdjustment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to stock_adjustment_url(assigns(:stock_adjustment))
  end
  
  def test_edit
    get :edit, :id => StockAdjustment.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    StockAdjustment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => StockAdjustment.first
    assert_template 'edit'
  end
  
  def test_update_valid
    StockAdjustment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => StockAdjustment.first
    assert_redirected_to stock_adjustment_url(assigns(:stock_adjustment))
  end
  
  def test_destroy
    stock_adjustment = StockAdjustment.first
    delete :destroy, :id => stock_adjustment
    assert_redirected_to stock_adjustments_url
    assert !StockAdjustment.exists?(stock_adjustment.id)
  end
end

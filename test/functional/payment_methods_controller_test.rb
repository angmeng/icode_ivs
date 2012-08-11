require 'test_helper'

class PaymentMethodsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => PaymentMethod.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    PaymentMethod.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    PaymentMethod.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to payment_method_url(assigns(:payment_method))
  end
  
  def test_edit
    get :edit, :id => PaymentMethod.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    PaymentMethod.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PaymentMethod.first
    assert_template 'edit'
  end
  
  def test_update_valid
    PaymentMethod.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PaymentMethod.first
    assert_redirected_to payment_method_url(assigns(:payment_method))
  end
  
  def test_destroy
    payment_method = PaymentMethod.first
    delete :destroy, :id => payment_method
    assert_redirected_to payment_methods_url
    assert !PaymentMethod.exists?(payment_method.id)
  end
end

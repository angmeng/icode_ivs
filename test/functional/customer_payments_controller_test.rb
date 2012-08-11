require 'test_helper'

class CustomerPaymentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => CustomerPayment.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    CustomerPayment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    CustomerPayment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to customer_payment_url(assigns(:customer_payment))
  end
  
  def test_edit
    get :edit, :id => CustomerPayment.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    CustomerPayment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CustomerPayment.first
    assert_template 'edit'
  end
  
  def test_update_valid
    CustomerPayment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CustomerPayment.first
    assert_redirected_to customer_payment_url(assigns(:customer_payment))
  end
  
  def test_destroy
    customer_payment = CustomerPayment.first
    delete :destroy, :id => customer_payment
    assert_redirected_to customer_payments_url
    assert !CustomerPayment.exists?(customer_payment.id)
  end
end

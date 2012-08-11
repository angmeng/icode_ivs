require 'test_helper'

class SupplierPaymentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => SupplierPayment.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    SupplierPayment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    SupplierPayment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to supplier_payment_url(assigns(:supplier_payment))
  end
  
  def test_edit
    get :edit, :id => SupplierPayment.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    SupplierPayment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SupplierPayment.first
    assert_template 'edit'
  end
  
  def test_update_valid
    SupplierPayment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SupplierPayment.first
    assert_redirected_to supplier_payment_url(assigns(:supplier_payment))
  end
  
  def test_destroy
    supplier_payment = SupplierPayment.first
    delete :destroy, :id => supplier_payment
    assert_redirected_to supplier_payments_url
    assert !SupplierPayment.exists?(supplier_payment.id)
  end
end

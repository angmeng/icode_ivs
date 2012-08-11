require 'test_helper'

class PurchaseInvoicesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => PurchaseInvoice.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    PurchaseInvoice.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    PurchaseInvoice.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to purchase_invoice_url(assigns(:purchase_invoice))
  end
  
  def test_edit
    get :edit, :id => PurchaseInvoice.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    PurchaseInvoice.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PurchaseInvoice.first
    assert_template 'edit'
  end
  
  def test_update_valid
    PurchaseInvoice.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PurchaseInvoice.first
    assert_redirected_to purchase_invoice_url(assigns(:purchase_invoice))
  end
  
  def test_destroy
    purchase_invoice = PurchaseInvoice.first
    delete :destroy, :id => purchase_invoice
    assert_redirected_to purchase_invoices_url
    assert !PurchaseInvoice.exists?(purchase_invoice.id)
  end
end

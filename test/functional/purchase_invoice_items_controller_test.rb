require 'test_helper'

class PurchaseInvoiceItemsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => PurchaseInvoiceItem.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    PurchaseInvoiceItem.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    PurchaseInvoiceItem.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to purchase_invoice_item_url(assigns(:purchase_invoice_item))
  end
  
  def test_edit
    get :edit, :id => PurchaseInvoiceItem.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    PurchaseInvoiceItem.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PurchaseInvoiceItem.first
    assert_template 'edit'
  end
  
  def test_update_valid
    PurchaseInvoiceItem.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PurchaseInvoiceItem.first
    assert_redirected_to purchase_invoice_item_url(assigns(:purchase_invoice_item))
  end
  
  def test_destroy
    purchase_invoice_item = PurchaseInvoiceItem.first
    delete :destroy, :id => purchase_invoice_item
    assert_redirected_to purchase_invoice_items_url
    assert !PurchaseInvoiceItem.exists?(purchase_invoice_item.id)
  end
end

require 'test_helper'

class BanksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Bank.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Bank.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Bank.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to bank_url(assigns(:bank))
  end
  
  def test_edit
    get :edit, :id => Bank.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Bank.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Bank.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Bank.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Bank.first
    assert_redirected_to bank_url(assigns(:bank))
  end
  
  def test_destroy
    bank = Bank.first
    delete :destroy, :id => bank
    assert_redirected_to banks_url
    assert !Bank.exists?(bank.id)
  end
end

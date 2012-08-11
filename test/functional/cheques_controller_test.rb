require 'test_helper'

class ChequesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Cheque.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Cheque.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Cheque.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to cheque_url(assigns(:cheque))
  end
  
  def test_edit
    get :edit, :id => Cheque.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Cheque.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Cheque.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Cheque.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Cheque.first
    assert_redirected_to cheque_url(assigns(:cheque))
  end
  
  def test_destroy
    cheque = Cheque.first
    delete :destroy, :id => cheque
    assert_redirected_to cheques_url
    assert !Cheque.exists?(cheque.id)
  end
end

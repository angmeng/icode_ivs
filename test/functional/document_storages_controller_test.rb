require 'test_helper'

class DocumentStoragesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => DocumentStorage.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    DocumentStorage.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    DocumentStorage.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to document_storage_url(assigns(:document_storage))
  end
  
  def test_edit
    get :edit, :id => DocumentStorage.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    DocumentStorage.any_instance.stubs(:valid?).returns(false)
    put :update, :id => DocumentStorage.first
    assert_template 'edit'
  end
  
  def test_update_valid
    DocumentStorage.any_instance.stubs(:valid?).returns(true)
    put :update, :id => DocumentStorage.first
    assert_redirected_to document_storage_url(assigns(:document_storage))
  end
  
  def test_destroy
    document_storage = DocumentStorage.first
    delete :destroy, :id => document_storage
    assert_redirected_to document_storages_url
    assert !DocumentStorage.exists?(document_storage.id)
  end
end

require 'test_helper'

class DocumentCategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => DocumentCategory.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    DocumentCategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    DocumentCategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to document_category_url(assigns(:document_category))
  end
  
  def test_edit
    get :edit, :id => DocumentCategory.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    DocumentCategory.any_instance.stubs(:valid?).returns(false)
    put :update, :id => DocumentCategory.first
    assert_template 'edit'
  end
  
  def test_update_valid
    DocumentCategory.any_instance.stubs(:valid?).returns(true)
    put :update, :id => DocumentCategory.first
    assert_redirected_to document_category_url(assigns(:document_category))
  end
  
  def test_destroy
    document_category = DocumentCategory.first
    delete :destroy, :id => document_category
    assert_redirected_to document_categories_url
    assert !DocumentCategory.exists?(document_category.id)
  end
end

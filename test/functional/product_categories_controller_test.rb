require 'test_helper'

class ProductCategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => ProductCategory.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    ProductCategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    ProductCategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to product_category_url(assigns(:product_category))
  end
  
  def test_edit
    get :edit, :id => ProductCategory.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    ProductCategory.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ProductCategory.first
    assert_template 'edit'
  end
  
  def test_update_valid
    ProductCategory.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ProductCategory.first
    assert_redirected_to product_category_url(assigns(:product_category))
  end
  
  def test_destroy
    product_category = ProductCategory.first
    delete :destroy, :id => product_category
    assert_redirected_to product_categories_url
    assert !ProductCategory.exists?(product_category.id)
  end
end

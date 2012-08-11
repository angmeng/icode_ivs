require 'test_helper'

class ProductMovementsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => ProductMovement.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    ProductMovement.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    ProductMovement.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to product_movement_url(assigns(:product_movement))
  end
  
  def test_edit
    get :edit, :id => ProductMovement.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    ProductMovement.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ProductMovement.first
    assert_template 'edit'
  end
  
  def test_update_valid
    ProductMovement.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ProductMovement.first
    assert_redirected_to product_movement_url(assigns(:product_movement))
  end
  
  def test_destroy
    product_movement = ProductMovement.first
    delete :destroy, :id => product_movement
    assert_redirected_to product_movements_url
    assert !ProductMovement.exists?(product_movement.id)
  end
end

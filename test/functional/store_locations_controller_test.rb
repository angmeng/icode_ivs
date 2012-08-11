require 'test_helper'

class StoreLocationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => StoreLocation.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    StoreLocation.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    StoreLocation.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to store_location_url(assigns(:store_location))
  end
  
  def test_edit
    get :edit, :id => StoreLocation.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    StoreLocation.any_instance.stubs(:valid?).returns(false)
    put :update, :id => StoreLocation.first
    assert_template 'edit'
  end
  
  def test_update_valid
    StoreLocation.any_instance.stubs(:valid?).returns(true)
    put :update, :id => StoreLocation.first
    assert_redirected_to store_location_url(assigns(:store_location))
  end
  
  def test_destroy
    store_location = StoreLocation.first
    delete :destroy, :id => store_location
    assert_redirected_to store_locations_url
    assert !StoreLocation.exists?(store_location.id)
  end
end

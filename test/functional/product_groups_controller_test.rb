require 'test_helper'

class ProductGroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_group" do
    assert_difference('ProductGroup.count') do
      post :create, :product_group => { }
    end

    assert_redirected_to product_group_path(assigns(:product_group))
  end

  test "should show product_group" do
    get :show, :id => product_groups(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => product_groups(:one).to_param
    assert_response :success
  end

  test "should update product_group" do
    put :update, :id => product_groups(:one).to_param, :product_group => { }
    assert_redirected_to product_group_path(assigns(:product_group))
  end

  test "should destroy product_group" do
    assert_difference('ProductGroup.count', -1) do
      delete :destroy, :id => product_groups(:one).to_param
    end

    assert_redirected_to product_groups_path
  end
end

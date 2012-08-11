require 'test_helper'

class PackingOrderItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:packing_order_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create packing_order_item" do
    assert_difference('PackingOrderItem.count') do
      post :create, :packing_order_item => { }
    end

    assert_redirected_to packing_order_item_path(assigns(:packing_order_item))
  end

  test "should show packing_order_item" do
    get :show, :id => packing_order_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => packing_order_items(:one).to_param
    assert_response :success
  end

  test "should update packing_order_item" do
    put :update, :id => packing_order_items(:one).to_param, :packing_order_item => { }
    assert_redirected_to packing_order_item_path(assigns(:packing_order_item))
  end

  test "should destroy packing_order_item" do
    assert_difference('PackingOrderItem.count', -1) do
      delete :destroy, :id => packing_order_items(:one).to_param
    end

    assert_redirected_to packing_order_items_path
  end
end
